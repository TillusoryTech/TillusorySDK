//
//  TiSDKInterface.h
//  TiSDK
//
//  Created by Cat66 on 2018/5/10.
//  Copyright © 2018年 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <OpenGLES/ES2/gl.h>

#pragma mark - TiSDK初始化类 -

@protocol TiSDKDelegate <NSObject>

- (void)success;

- (void)failure;

@end

@interface TiSDK : NSObject

/**
 * 单例
 */
+ (TiSDK *)shareInstance;

/**
 * 初始化函数，在线鉴权
 * @param key TiSDK在线鉴权key
 * @param delegate TiSDKDelegate代理
 */
- (void)initSDK:(NSString *)key withDelegate:(id<TiSDKDelegate>)delegate;

/**
 * 初始化函数，离线鉴权
 * @param license TiSDK离线鉴权license
 * @return 离线鉴权是否成功
 */
- (BOOL)initOffline:(NSString *)license;

// 设置SDK资源拷贝至沙盒的目标路径
- (void)setResPath:(NSString *)path;

// 获取SDK资源拷贝至沙盒的目标路径
- (NSString *)getResPath;

// 获取SDK模型文件拷贝至沙盒的目标路径
- (NSString *)getModelPath;

// 获取SDK美颜文件拷贝至沙盒的目标路径
- (NSString *)getBeautyPath;

// 获取SDK滤镜文件拷贝至沙盒的目标路径
- (NSString *)getFilterPath;

// 获取SDK贴纸特效文件拷贝至沙盒的目标路径
- (NSString *)getStickerPath;

// 获取SDK互动特效文件拷贝至沙盒的目标路径
- (NSString *)getInteractionPath;

// 获取SDK礼物特效文件拷贝至沙盒的目标路径
- (NSString *)getGiftPath;

// 获取SDK面具特效文件拷贝至沙盒的目标路径
- (NSString *)getMaskPath;

// 获取SDK美妆特效文件拷贝至沙盒的目标路径
- (NSString *)getMakeupPath;

// 获取SDK美妆-腮红特效文件拷贝至沙盒的目标路径
- (NSString *)getBlusherPath;

// 获取SDK美妆-眉毛特效文件拷贝至沙盒的目标路径
- (NSString *)getEyeBrowPath;

// 获取SDK美妆-眼影特效文件拷贝至沙盒的目标路径
- (NSString *)getEyeShadowPath;

// 获取SDK美妆-唇彩特效文件拷贝至沙盒的目标路径
- (NSString *)getLipGlossPath;

// 获取SDK绿幕特效文件拷贝至沙盒的目标路径
- (NSString *)getGreenScreenPath;

// 获取SDK水印特效文件拷贝至沙盒的目标路径
- (NSString *)getWatermarkPath;

// 获取SDK人像抠图特效文件拷贝至沙盒的目标路径
- (NSString *)getPortraitPath;

// 获取SDK手势识别特效文件拷贝至沙盒的目标路径
- (NSString *)getGesturePath;

// 设置SDK资源远程根目录
- (void)setResUrl:(NSString *)url;

// 获取SDK资源远程根目录
- (NSString *)getResUrl;

// 获取SDK模型文件远程地址
- (NSString *)getModelUrl;

// 获取SDK美颜文件远程地址
- (NSString *)getBeautyUrl;

// 获取SDK滤镜文件远程地址
- (NSString *)getFilterUrl;

// 获取SDK贴纸特效文件远程地址
- (NSString *)getStickerUrl;

// 获取SDK互动特效文件远程地址
- (NSString *)getInteractionUrl;

// 获取SDK礼物特效文件远程地址
- (NSString *)getGiftUrl;

// 获取SDK面具特效文件远程地址
- (NSString *)getMaskUrl;

// 获取SDK美妆特效文件远程地址
- (NSString *)getMakeupUrl;

// 获取SDK绿幕特效文件远程地址
- (NSString *)getGreenScreenUrl;

// 获取SDK水印特效文件远程地址
- (NSString *)getWatermarkUrl;

// 获取SDK人像抠图特效文件远程地址
- (NSString *)getPortraitUrl;

// 获取SDK手势识别特效文件远程地址
- (NSString *)getGestureUrl;

// 日志开关
- (void)setLog:(BOOL)enable;

@end

#pragma mark - TiSDK渲染管理器类 -

@interface TiSDKManager : NSObject

// 视频帧格式
typedef NS_ENUM(NSInteger, TiImageFormatEnum) {
    BGRA = 0,
    NV21 = 1,
    RGB = 2,
    RGBA = 3,
    NV12 = 4,
    I420 = 5
};

// 视频帧旋转角度
typedef NS_ENUM(NSInteger, TiRotationEnum){
    CLOCKWISE_0 = 0,
    CLOCKWISE_90 = 90,
    CLOCKWISE_180 = 180,
    CLOCKWISE_270 = 270
};

// 抖动类型
typedef NS_ENUM(NSInteger, TiRockEnum) {
    NO_ROCK = 0, // 无抖音特效
    DAZZLED_COLOR_ROCK = 1, // 炫彩抖动
    LIGHT_COLOR_ROCK = 2, // 轻彩抖动
    VISION_SHADOW_ROCK = 3, // 幻觉残影
    NEON_LIGHT_ROCK = 4, // 霓虹灯
    REFLECTION_MIRROR_ROCK = 5, // 反光镜
    VIRTUAL_MIRROR_ROCK = 6, // 虚拟镜像
    FOUR_SCREEN_MIRROR_ROCK = 7, // 四屏镜像
    FUZZY_BORDER_ROCK = 8, // 边框模糊
    FUZZY_SPLIT_SCREEN_ROCK = 9, // 模糊分屏
    FOUR_GRID_VIEW_ROCK = 10, // 四分屏
    NINE_GRID_VIEW_ROCK = 11, // 九宫格
    ASTRAL_PROJECTION_ROCK = 12, // 灵魂出窍
    DIZZY_GIDDY_ROCK = 13, // 头晕目眩
    DYNAMIC_SPLIT_SCREEN_ROCK = 14, // 动感分屏
    BLACK_WHITE_FILM_ROCK = 15, // 黑白电影
    BULGE_DISTORTION__ROCK = 16, // 魔法镜面
    GRAY_PETRIFACTION_ROCK = 17, // 瞬间石化
    FROSTED_GLASS_ROCK = 18 // 毛玻璃
};

// 哈哈镜类型
typedef NS_ENUM(NSInteger, TiDistortionEnum) {
    NO_DISTORTION = 0, // 无
    ET_DISTORTION = 1, // 外星人
    PEAR_FACE_DISTORTION = 2, // 梨梨脸
    SLIM_FACE_DISTORTION = 3, // 瘦瘦脸
    SQUARE_FACE_DISTORTION = 4 // 方方脸
};

// 美发类型
typedef NS_ENUM(NSInteger, TiHairEnum) {
    NO_HAIR = 0, // 无
    MY_PURPLE_HAIR = 1, // 神秘紫
    CHOCOLATE_HAIR = 2, // 巧克力
    AJ_BROWN_HAIR = 3, // 青木棕
    CA_BROWN_HAIR = 4, // 焦糖棕
    HON_BROWN_HAIR = 5, // 蜂蜜醇棕
    LTG_BROWN_HAIR = 6, // 浅金棕
    ROSE_GOLD_HAIR = 7, // 玫瑰金
    FW_GOLD_HAIR = 8, // 亚麻白金
    SS_ORANGE_HAIR = 9, // 落日橘
    FL_ORANGE_HAIR = 10, // 亚麻浅橘
    VINTAGE_ROSE_HAIR = 11, // 复古玫瑰
    TENDER_ROSE_HAIR = 12, // 深玫瑰
    MG_PURPLE_HAIR = 13, // 烟灰雾紫
    SPR_BROWN_HAIR = 14, // 粉玫甜棕
    FROG_TARO_HAIR = 15, // 雾霾香芋
    PEACOCK_BLUE_HAIR = 16, // 孔雀蓝
    FB_GRAY_HAIR = 17, // 雾霾蓝灰
    FG_BROWN_HAIR = 18, // 亚麻灰棕
    FL_GRAY_HAIR = 19 // 亚麻浅灰
};

// 一键美颜类型
typedef NS_ENUM(NSInteger, TiOnekeyBeautyEnum) {
    STANDARD_ONEKEY_BEAUTY = 0, // 标准
    DELICATE_ONEKEY_BEAUTY = 1, // 精致
    LOVELY_ONEKEY_BEAUTY = 2, // 可爱
    INTERNET_CELEBRITY_ONEKEY_BEAUTY = 3, // 网红
    NATURAL_ONEKEY_BEAUTY = 4, // 自然
    LOLITA_ONEKEY_BEAUTY = 5, // 萝莉
    ELEGANT_ONEKEY_BEAUTY = 6, // 优雅
    FIRST_LOVE_ONEKEY_BEAUTY = 7, // 初恋
    GODNESS_ONEKEY_BEAUTY = 8, // 女神
    ADVANCED_ONEKEY_BEAUTY = 9, // 高级
    LOW_END_ONEKEY_BEAUTY = 10 // 低端机适配
};

// 脸型类型
typedef NS_ENUM(NSInteger, TiFaceShapeEnum) {
    CLASSIC_FACE_SHAPE = 0, // 经典
    SQUARE_FACE_SHAPE = 1, // 方脸
    LONG_FACE_SHAPE = 2, // 长脸
    ROUNDED_FACE_SHAPE = 3, // 圆脸
    SLIM_FACE_SHAPE = 4 // 瘦脸
};

+ (TiSDKManager *)shareManager;

/**
 * 纹理渲染接口函数一
 *
 * @param texture2D 待渲染纹理
 * @param imageWidth 纹理宽度
 * @param imageHeight 纹理高度
 * @param rotation 纹理转为正向（home键向下）待旋转角度
 * @param isMirror 是否存在镜像
 *
 * @return 渲染后的纹理
 */
- (GLuint)renderTexture2D:(GLuint)texture2D Width:(CGFloat)imageWidth Height:(CGFloat)imageHeight Rotation:(TiRotationEnum)rotation Mirror:(BOOL)isMirror;

/**
 * 纹理渲染接口函数二
 *
 * @param texture2D 待渲染纹理
 * @param imageWidth 纹理宽度
 * @param imageHeight 纹理高度
 * @param rotation 纹理转为正向（home键向下）待旋转角度
 * @param isMirror 是否存在镜像
 * @param faceNumber 人脸相关特效可支持的人脸数 [1, 5]
 *
 * @return 渲染后的纹理
 */
- (GLuint)renderTexture2D:(GLuint)texture2D Width:(CGFloat)imageWidth Height:(CGFloat)imageHeight Rotation:(TiRotationEnum)rotation Mirror:(BOOL)isMirror FaceNumber:(int)faceNumber;

/**
 * pixelBuffer渲染接口函数一
 *
 * @param pixels 待渲染视频帧
 * @param imageWidth 纹理宽度
 * @param imageHeight 纹理高度
 * @param rotation 纹理转为正向（home键向下）待旋转角度
 * @param isMirror 是否存在镜像
 *
 */
- (void)renderPixels:(unsigned char *)pixels Format:(TiImageFormatEnum)imageFormat Width:(CGFloat)imageWidth Height:(CGFloat)imageHeight Rotation:(TiRotationEnum)rotation Mirror:(BOOL)isMirror;

/**
 * pixelBuffer渲染接口函数二
 *
 * @param pixels 待渲染视频帧
 * @param imageWidth 视频帧宽度
 * @param imageHeight 视频帧高度
 * @param rotation 视频帧转为正向（home键向下）待旋转角度
 * @param isMirror 是否存在镜像
 * @param faceNumber 人脸相关特效可支持的人脸数 [1, 5]
 *
 */
- (void)renderPixels:(unsigned char *)pixels Format:(TiImageFormatEnum)imageFormat Width:(CGFloat)imageWidth Height:(CGFloat)imageHeight Rotation:(TiRotationEnum)rotation Mirror:(BOOL)isMirror FaceNumber:(int)faceNumber;

/**
 * image渲染接口函数
 *
 * @param pixels 待渲染图片
 * @param imageWidth 图片宽度
 * @param imageHeight 图片高度
 * @param rotation 图片转为正向（home键向下）待旋转角度
 * @param isMirror 是否存在镜像
 * @param faceNumber 人脸相关特效可支持的人脸数 [1, 5]
 *
 */
- (void)renderImage:(unsigned char *)pixels Format:(TiImageFormatEnum)imageFormat Width:(CGFloat)imageWidth Height:(CGFloat)imageHeight Rotation:(TiRotationEnum)rotation Mirror:(BOOL)isMirror FaceNumber:(int)faceNumber;

/**
 * image是否变更
 * 如果是用于视频流渲染，则无需调用；如果是用于图片渲染，则更换图片时设置为true，没有更换则设置为false
 *
 * @param isChanged 是否更换，默认为true
 *
 */
- (void)setImageIsChanged:(BOOL)isChanged;

/**
 * 渲染特效总开关
 *
 * @param enable YES是打开渲染；NO是关闭开关
 */
-(void)setRenderEnable:(bool)enable;

/**
 * 开启/关闭美颜特效函数
 *
 * @param enable 是否开启美颜特效
 */
- (void)setBeautyEnable:(BOOL)enable;

/**
 * 设置美颜-美白特效参数函数
 *
 * @param param [0, 100]
 */
- (void)setSkinWhitening:(int)param;

/**
 * 设置美颜-磨皮特效参数函数
 *
 * @param param [0, 100]
 */
- (void)setSkinBlemishRemoval:(int)param;

///**
// * 设置美颜-精准美肤特效参数函数
// *
// * @param param [0, 100]
// */
//- (void)setSkinPreciseBeauty:(int)param;

/**
 * 设置美颜-粉嫩特效参数函数
 *
 * @param param [0, 100]
 */
- (void)setSkinTenderness:(int)param;

/**
 * 设置美颜-清晰特效参数函数
 *
 * @param param [0, 100]
 */
- (void)setSkinSharpness:(int)param;

/**
 * 设置美颜-亮度特效参数函数
 *
 * @param param [-50, 50]
 */
- (void)setSkinBrightness:(int)param;

/**
 * 设置美颜-饱和特效参数函数
 *
 * @param param [-50, 50]
 */
- (void)setSkinSaturation:(int)param;

/**
 * 设置精准美肤-黑眼圈特效参数函数
 *
 * @param param [0, 100]
 */
- (void)setDarkCircle:(int)param;

/**
 * 设置精准美肤-立体特效参数函数
 *
 * @param param [0, 100]
 */
- (void)setHighlight:(int)param;

/**
 * 设置精准美肤-精细磨皮特效参数函数
 *
 * @param param [0, 100]
 */
- (void)setSkinPreciseBeauty:(int)param;

/**
 * 设置精准美肤-精细粉嫩特效参数函数
 *
 * @param param [0, 100]
 */
- (void)setPreciseTenderness:(int)param;

/**
 * 设置精准美肤-法令纹特效参数函数
 *
 * @param param [0, 100]
 */
- (void)setNasolabialFold:(int)param;

/**
 * 设置精准美肤-鱼尾纹特效参数函数
 *
 * @param param [0, 100]
 */
- (void)setCrowsFeet:(int)param;

/**
 * 打开/关闭美型特效函数
 *
 * @param enable 是否打开美型特效
 */
- (void)setFaceTrimEnable:(BOOL)enable;

/**
 * 设置美型-大眼特效参数函数
 *
 * @param param [0, 100]
 */
- (void)setEyeMagnifying:(int)param;

/**
 * 设置美型-瘦脸特效参数函数
 *
 * @param param [0, 100]
 */
- (void)setChinSlimming:(int)param;

/**
 * 设置美型-窄脸特效参数函数
 *
 * @param param [0, 100]
 */
- (void)setFaceNarrowing:(int)param;

/**
 * 设置美型-瘦颧骨特效参数函数
 *
 * @param param [0, 100]
 */
- (void)setCheekboneSlimming:(int)param;

/**
 * 设置美型-瘦下颌特效参数函数
 *
 * @param param [0, 100]
 */
- (void)setJawboneSlimming:(int)param;

/**
 * 设置美型-下巴特效参数函数
 *
 * @param param [-50, 50]
 */
- (void)setJawTransforming:(int)param;

/**
 * 设置美型-削下巴特效参数函数
 *
 * @param param [0, 100]
 */
- (void)setJawSlimming:(int)param;

/**
 * 设置美型-额头特效参数函数
 *
 * @param param [-50, 50]
 */
- (void)setForeheadTransforming:(int)param;

/**
 * 设置美型-内眼角特效参数函数
 *
 * @param param [-50, 50]
 */
- (void)setEyeInnerCorners:(int)param;

/**
 * 设置美型-外眼尾特效参数函数
 *
 * @param param [-50, 50]
 */
- (void)setEyeOuterCorners:(int)param;

/**
 * 设置美型-眼间距特效参数函数
 *
 * @param param [-50, 50]
 */
- (void)setEyeSpacing:(int)param;

/**
 * 设置美型-眼角特效参数函数
 *
 * @param param [-50, 50]
 * 默认值为0
 */
- (void)setEyeCorners:(int)param;

/**
 * 设置美型-瘦鼻特效参数函数
 *
 * @param param [0, 100]
 */
- (void)setNoseMinifying:(int)param;

/**
 * 设置美型-长鼻特效参数函数
 *
 * @param param [0, 100]
 * 默认值为0
 */
- (void)setNoseElongating:(int)param;

/**
 * 设置美型-嘴型特效参数函数
 *
 * @param param [-50, 50]
 */
- (void)setMouthTransforming:(int)param;

/**
 * 设置美型-嘴高低特效参数函数
 *
 * @param param [-50, 50]
 */
- (void)setMouthHeight:(int)param;

/**
 * 设置美型-唇薄厚特效参数函数
 *
 * @param param [-50, 50]
 */
- (void)setMouthLipSize:(int)param;

/**
 * 设置美型-扬嘴角特效参数函数
 *
 * @param param [0, 100]
 */
- (void)setMouthSmiling:(int)param;

/**
 * 设置美型-眉高低特效参数函数
 *
 * @param param [-50, 50]
 */
- (void)setBrowHeight:(int)param;

/**
 * 设置美型-眉长短特效参数函数
 *
 * @param param [-50, 50]
 */
- (void)setBrowLength:(int)param;

/**
 * 设置美型-眉间距特效参数函数
 *
 * @param param [-50, 50]
 */
- (void)setBrowSpace:(int)param;

/**
 * 设置美型-眉粗细特效参数函数
 *
 * @param param [-50, 50]
 */
- (void)setBrowSize:(int)param;

/**
 * 设置美型-提眉尾特效参数函数
 *
 * @param param [0, 100]
 */
- (void)setBrowCorner:(int)param;

/**
 * 设置美型-美牙特效参数函数
 *
 * @param param [0, 100]
 */
- (void)setTeethWhitening:(int)param;

/**
 * 美颜滤镜设置函数
 * 新版本滤镜接口
 *
 * @param filterName 滤镜名称
 * @param param 滤镜参数
 */
- (void)setBeautyFilter:(NSString *)filterName Param:(int)param;

/**
 * 设置抖动特效参数函数
 *
 * @param rockEnum 参考宏定义TiRockEnum
 */
- (void)setRockEnum:(TiRockEnum)rockEnum;

/**
 * 设置哈哈镜特效参数函数
 *
 * @param distortionEnum 参考宏定义TiDistortionEnum
 */
- (void)setDistortionEnum:(TiDistortionEnum)distortionEnum;

/**
 * 切换贴纸函数
 *
 * @param stickerName 贴纸名称
 */
- (void)setStickerName:(NSString *)stickerName;

/**
 * 设置互动特效参数函数
 *
 * @param interactionName 互动特效名称
 */
- (void)setInteraction:(NSString *)interactionName;

/**
 * 设置礼物特效参数函数
 *
 * @param giftName 礼物名称
 */
- (void)setGift:(NSString *)giftName;

/**
 * 设置面具特效参数函数
 *
 * @param maskName 面具名称
 */
- (void)setMask:(NSString *)maskName;

/**
 * 设置水印参数函数
 *
 * @param enable  true: 开启 false: 关闭
 * @param x         水印左上角横坐标[0, 100]
 * @param y         水印右上角纵坐标[0, 100]
 * @param ratio    水印横向占据屏幕的比例[0, 100]
 */
- (void)setWatermark:(BOOL)enable Left:(int)x Top:(int)y Ratio:(int)ratio FileName:(NSString *)fileName;

/**
 * 设置绿幕特效参数函数一
 *
 * @param greenScreenName 幕布名称
 */
- (void)setGreenScreen:(NSString *)greenScreenName;

/**
 * 设置绿幕特效参数函数二
 *
 * @param greenScreenName 幕布名称
 * @param similarity 相似度
 * @param smoothness 平滑度
 * @param alpha 透明度
 */
- (void)setGreenScreen:(NSString *)greenScreenName Similarity:(int)similarity Smoothness:(int)smoothness Alpha:(int)alpha;

/**
 * 设置人像抠图特效参数函数
 *
 * @param portraitName 人像抠图特效名称
 */
- (void)setPortrait:(NSString *)portraitName;

/**
 * 设置美发特效参数函数
 *
 * @param hairEnum 参考宏定义TiHairEnum
 * @param param 美发参数
 */
- (void)setHairEnum:(TiHairEnum)hairEnum Param:(int)param;

/**
 * 设置手势识别特效参数函数
 *
 * @param gestureName 手势识别特效名称
 */
- (void)setGesture:(NSString *)gestureName;

/**
 * 美妆特效开关函数
 *
 * @param enable 是否开启美妆
 */
- (void)setMakeupEnable:(bool)enable;

/**
 * 美妆-腮红特效开关函数
 *
 * @param name 腮红特效名称
 * @param param 腮红特效参数
 */
- (void)setBlusher:(NSString*)name Param:(int)param;

/**
 * 美妆-眉毛特效开关函数
 *
 * @param name 眉毛特效名称
 * @param param 眉毛特效参数
 */
- (void)setEyeBrow:(NSString*)name Param:(int)param;

/**
 * 美妆-睫毛特效开关函数
 *
 * @param name 睫毛特效名称
 * @param param 睫毛特效参数
 */
- (void)setEyeLash:(NSString*)name Param:(int)param;

/**
 * 美妆-眼影特效开关函数
 *
 * @param name 眼影特效名称
 * @param param 眼影特效参数
 */
- (void)setEyeShadow:(NSString*)name Param:(int)param;

/**
 * 美妆-眼线特效开关函数
 *
 * @param name 眼线特效名称
 * @param param 眼线特效参数
 */
- (void)setEyeLine:(NSString*)name Param:(int)param;

/**
 * 美妆-唇彩特效开关函数
 *
 * @param name 唇彩特效名称
 * @param param 唇彩特效参数
 */
- (void)setLipGLoss:(NSString*)name Param:(int)param;

/**
 * 美体特效开关函数
 *
 *
 * @param enable YES是打开渲染；NO是关闭开关
 */
- (void)setBodyShapingEnable:(BOOL)enable;

/**
 * 美体-长腿特效函数
 *
 * 美体特效目前仅限用于图片编辑条件下
 *
 * @param param 长腿特效参数
 * @param top 长腿特效上边界值
 * @param bottom 长腿特效下边界值
 */
- (void)setLongLeg:(int)param Top:(int)top Bottom:(int)bottom;

/**
 * 美体-瘦身特效函数
 *
 * 美体特效目前仅限用于图片编辑条件下
 *
 * @param param 瘦身特效参数
 * @param left 瘦身特效左边界值
 * @param right 瘦身特效右边界值
 */
- (void)setSlimBody:(int)param Left:(int)left Right:(int)right;

/**
 * 一键美颜
 *
 * @param onekeyBeautyEnum 一键美颜类型，参考枚举类型 TiOnekeyBeautyEnum
 * @param param [0, 100]
 */
- (void)setOnekeyBeauty:(TiOnekeyBeautyEnum)onekeyBeautyEnum Param:(int)param;

/**
 * 脸型
 *
 * @param faceShapeNum 脸型类型，参考枚举类型 TiFaceShapeEnum
 * @param param [0, 100]
 */
- (void)setFaceShape:(TiFaceShapeEnum)faceShapeNum Param:(int)param;

/**
 * 设置人脸识别距离
 *
 * @param level 识别距离级别，默认值为1，取值范围为[0, 1, 2, 3, 4, 5, 6]，值越大，识别距离越远，但性能会相应下降，对机器硬件要求越高
 */
- (void)setTrackDistance:(int)level; 

/**
 * 获取识别到的人脸数目
 * @return -1（没有检测人脸）, 其他返回检测到的人脸数量
 */
- (int)getFaceNumber;

/**
 * 开启或关闭参数最大值限制，默认开启
 * @param enabled true:开启限制（即限定参数传入最大值为100）｜ false: 关闭限制（即用户可以根据需要设置超过默认最大值100的参数值）
 */
- (void)setCustomMaximumEnabled:(BOOL)enabled;

/**
 * 资源释放函数
 */
- (void)destroy;

@end

