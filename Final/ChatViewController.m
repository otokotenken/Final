//
//  ChatViewController.m
//  Final
//
//  Created by DetroitLabs on 7/18/16.
//  Copyright © 2016 DetroitLabs. All rights reserved.
//

#import "ChatViewController.h"
#import "FirebaseDatabase/FirebaseDatabase.h"
#import "FirebaseAuth/FIRAuth.h"
#import "JSQMessagesViewController/JSQMessagesViewController.h"
#import "JSQMessagesViewController/JSQMessagesBubbleImage.h"
#import "JSQMessagesViewController/JSQMessagesBubbleImageFactory.h"
#import "JSQMessagesViewController/JSQMessage.h"
#import "JSQSystemSoundPlayer/JSQSystemSoundPlayer.h"
#import "JSQMessagesTimestampFormatter.h"


@import Firebase;

@interface ChatViewController ()
{
    FIRDatabaseHandle _msgHandle;
}
@property (nonatomic, strong) FIRDatabaseQuery *typingQuery;
@property (nonatomic, strong) FIRDatabaseReference *rootRef;
@property (nonatomic, strong) FIRDatabaseReference *isTypingRef;
@property (nonatomic, strong) NSMutableArray *messages;
@property (nonatomic, strong) JSQMessagesBubbleImage * outgoingBubbleImageView;
@property (nonatomic, strong) JSQMessagesBubbleImage * incomingBubbleImageView;
@property (nonatomic) Boolean isTyping;
@property (weak, nonatomic) IBOutlet JSQMessagesLabel *messageBubbleTopLabel;
@property (strong, nonatomic) NSString *dateString;
@end

@implementation ChatViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"iChat";
    
    [self setupBubbles];
    
    _messages = [[NSMutableArray alloc] init];
    //removes the avatars
    self.collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeZero;
    self.collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero;
    //removes the built in toolbar button
    self.inputToolbar.contentView.leftBarButtonItem = nil ;
    
    _rootRef= [[FIRDatabase database] reference];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self observeMessages];
    [self observeIsTyping];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helpers

-(void)setupBubbles {
    JSQMessagesBubbleImageFactory * factory = [[JSQMessagesBubbleImageFactory alloc ]init];
    
    _outgoingBubbleImageView = [factory outgoingMessagesBubbleImageWithColor:[UIColor colorWithHue:130.0f / 360.0f
                                                                                        saturation:0.68f
                                                                                        brightness:0.84f
                                                                                             alpha:1.0f]];
    
    _incomingBubbleImageView = [factory incomingMessagesBubbleImageWithColor:[UIColor colorWithHue:201.0f / 360.0f
                                                                                        saturation:0.78f
                                                                                        brightness:0.92f
                                                                                             alpha:1.0f]];
}

-(void)addMessagewithId:(NSString*) senderId andText:(NSString*) text {
    JSQMessage* message = [JSQMessage messageWithSenderId:senderId displayName:@"" text:text];
    
    [_messages addObject:message];
}


-(void)observeMessages {
    _msgHandle = [[_rootRef child:@"messages"] observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot *snapshot) {
        
        NSDictionary<NSString *, NSString *> *message = snapshot.value;
        
        NSString *name = message[@"senderId"];
        NSString *text = message[@"text"];
        _dateString = message[@"date"];
        
        [self addMessagewithId:name andText:text];
        
        // animates the receiving of a new message on the view
        [self finishReceivingMessage];
    }];
}

-(void)observeIsTyping {
    _isTypingRef = [[_rootRef child:@"isTypingIndicator"] child:self.senderId];
    //removes reference in database once app is closed
    [_isTypingRef onDisconnectRemoveValue];
    
    _typingQuery = [[[_rootRef child:@"isTypingIndicator"] queryOrderedByValue] queryEqualToValue:@"1"];
    
    [_typingQuery observeEventType:FIRDataEventTypeValue withBlock:  ^ (FIRDataSnapshot *snapshot) {
        
        if (snapshot.hasChildren) {
            if (snapshot.childrenCount == 1 && self.isTyping) {
                //  You're the only typing, don't show the indicator
                [self setShowTypingIndicator:NO];
            } else {
                //  others typing
                [self setShowTypingIndicator:YES];
                //setShowTypingIncdicator is a method of JSQMessagesViewController
            }
        } else {
            [self setShowTypingIndicator:NO];
        }
        [self scrollToBottomAnimated:YES];
    }];
}

-(void)sendIsTyping {
    
    // Push data to Firebase Database
    if(_isTyping) {
        [_isTypingRef setValue:@"1"];
    } else {
        [_isTypingRef setValue:@"0"];
    }
}

#pragma mark - button actions

-(void)didPressSendButton:(UIButton *)button withMessageText:(NSString *)text senderId:(NSString *)senderId senderDisplayName:(NSString *)senderDisplayName date:(NSString *)date {
    
    NSDictionary *mdata = @{@"text": text, @"senderId":senderId,  @"date":_dateString};
    
    // Push data to Firebase Database
    [[[_rootRef child:@"messages"] childByAutoId] setValue:mdata];
    
    _isTyping =false;
    [self sendIsTyping];
    [self finishSendingMessage];
}


#pragma mark - TextView
-(void)textViewDidChange:(UITextView *)textView {
    [super textViewDidChange:textView];
    
    _isTyping =  ![textView.text  isEqual: @""];
    //change isTyping to true if the text field is not empty
    [self sendIsTyping];
}

#pragma mark - CollectionView

- (id<JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView messageDataForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [_messages objectAtIndex:indexPath.row] ;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _messages.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JSQMessagesCollectionViewCell * cell = (JSQMessagesCollectionViewCell*)[super  collectionView:collectionView cellForItemAtIndexPath:indexPath];
    
    JSQMessage * msg = [_messages objectAtIndex:indexPath.row] ;
    
    if ([msg.senderId isEqualToString: self.senderId] ) {
        cell.textView.textColor = [UIColor whiteColor];
    } else {
        cell.textView.textColor = [UIColor blackColor];
    }
    return cell;
}

-(id<JSQMessageBubbleImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView messageBubbleImageDataForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JSQMessage * msg = [_messages objectAtIndex:indexPath.row] ;
    
    if ([msg.senderId isEqualToString: self.senderId] ) {
        return _outgoingBubbleImageView;
    } else {
        return _incomingBubbleImageView;
    }
}

-(id<JSQMessageAvatarImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView avatarImageDataForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath {
    return 18.0f;
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath {
    JSQMessage *message = [self.messages objectAtIndex:indexPath.item];
    /**
     *  iOS7-style sender name labels
     */
    if ([message.senderId isEqualToString:self.senderId]) {
        return nil;
    }
    
    if (indexPath.item - 1 > 0) {
        JSQMessage *previousMessage = [self.messages objectAtIndex:indexPath.item - 1];
        if ([[previousMessage senderId] isEqualToString:message.senderId]) {
            return nil;
        }
    }
    
    /**
     *  Don't specify attributes to use the defaults.
     */
    return [[NSAttributedString alloc] initWithString:message.senderId];
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath {
        JSQMessage *message = [self.messages objectAtIndex:indexPath.item];
    /**
     *  This logic should be consistent with what you return from `heightForCellTopLabelAtIndexPath:`
     *  The other label text delegate methods should follow a similar pattern.
     *
     *  Show a timestamp for every 3rd message
     */
    if (indexPath.item == _messages.count -1) {
        
//        NSDate *myDate = [[NSDate alloc] init];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMdd HH:mm:ss"];  //20160217 13:14:22
        _dateString = [dateFormatter stringFromDate: message.date];
//        [[NSAttributedString alloc] initWithString:message.dateString];
//        return [[JSQMessagesTimestampFormatter sharedFormatter] attributedTimestampForDate:message.date];
        return [[NSAttributedString alloc]initWithString:_dateString];
    }
    return nil;
}

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  Each label in a cell has a `height` delegate method that corresponds to its text dataSource method
     */
    
    /**
     *  This logic should be consistent with what you return from `attributedTextForCellTopLabelAtIndexPath:`
     *  The other label height delegate methods should follow similarly
     *
     *  Show a timestamp for every 3rd message
     */
    if (indexPath.item % 3 == 0) {
        return kJSQMessagesCollectionViewCellLabelHeightDefault;
    }
    
    return 0.0f;
}


@end
