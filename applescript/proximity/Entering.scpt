FasdUAS 1.101.10   ��   ��    k             l     �� ��    ( " Disable the screen Saver Password       	  l     
�� 
 I    �� ��
�� .sysoexecTEXT���     TEXT  m        M Gdefaults -currentHost write com.apple.screensaver askForPassword -int 0   ��  ��   	     l    ��  I   �� ��
�� .sysoexecTEXT���     TEXT  m        ~/local.bin/notif   ��  ��        l     �� ��       Turn OFF the screen saver         l    ��  O       I   ������
�� .aevtquitnull��� ��� null��  ��    m      \null     ߀��  ]�ScreenSaverEngine.app�����   �C{�i> ����﷈�<،�zx��� ƈ�,�????@  alis    �  Macintosh HD               �\(XH+    ]�ScreenSaverEngine.app                                            `9�[�        ����  	                	Resources     �\��      �\W�      ]�  ]�  ]�  ]�  �  �  �  gMacintosh HD:System:Library:Frameworks:ScreenSaver.framework:Versions:A:Resources:ScreenSaverEngine.app   ,  S c r e e n S a v e r E n g i n e . a p p    M a c i n t o s h   H D  ZSystem/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app  / ��  ��        l     �� ��    &   tell application "Address Book"         l     ��  ��       	if not unsaved then      ! " ! l     �� #��   #   		try    "  $ % $ l     �� &��   &   			quit    %  ' ( ' l     �� )��   )   			delay 1    (  * + * l     �� ,��   ,  
 		end try    +  - . - l     �� /��   /   	end if    .  0 1 0 l     �� 2��   2  	 end tell    1  3 4 3 l     �� 5��   5 $  Reconnect to the Address Book    4  6 7 6 l     �� 8��   8 c ] do shell script "defaults write com.apple.AddressBook ABCheckForPhoneNextTime -boolean true"    7  9 : 9 l     �� ;��   ; 
  try    :  < = < l     �� >��   > ' ! 	tell application "Address Book"    =  ? @ ? l     �� A��   A  	 		launch    @  B C B l     �� D��   D  
 	end tell    C  E F E l     �� G��   G ( " 	tell application "System Events"    F  H I H l     �� J��   J 8 2 		set the visible of process "Address Book" to no    I  K L K l     �� M��   M  
 	end tell    L  N�� N l     �� O��   O   end try   ��       �� P Q��   P ��
�� .aevtoappnull  �   � **** Q �� R���� S T��
�� .aevtoappnull  �   � **** R k      U U   V V   W W  ����  ��  ��   S   T  ��  ��
�� .sysoexecTEXT���     TEXT
�� .aevtquitnull��� ��� null�� �j O�j O� *j U ascr  ��ޭ