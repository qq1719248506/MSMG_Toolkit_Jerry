//#################################################
//ע�⣺����PECMDԴ�룬����VBS�ű�������
//PECMD���������أ�pecmd.net
//#################################################
//ֱ�ӵ�PECMD��
SET &ag=%*
%&ag%
EXIT FILE

//#################################################
//��Ȩ����
//#################################################
_SUB surun
EXEC -su %CurDir%\Toolkit.cmd
_END

//#################################################
//�����ļ�
//#################################################
_SUB importfile
//���ļ�
BROW Դ�ļ�,%CurDir%\DVD,���һ��WIM/ESD����,WIM����|*.wim|ESD����|*.esd|,0x02082000
IFEX %Դ�ļ�%,! 
{
	WRIT -,+0,����δѡ��Դ�����ļ���������ѡ��
	EXIT FILE
}
//��ȡ��չ��
FEXT ��չ��=%Դ�ļ�%
//��ȡĿ¼��
FDIR Ŀ¼=%Դ�ļ�%
IFEX |%Ŀ¼%=%CurDir%\DVD\sources,
{
	//��ȡ�ļ���
	FNAM �ļ���=%Դ�ļ�%
	IFEX |%�ļ���%=install,! FILE %Դ�ļ�%>>%Ŀ¼%\install.%��չ��%
}!
{
	//���Ƶ�Ŀ��Ŀ¼
	FILE %Դ�ļ�%=>%CurDir%\DVD\sources\install.%��չ��%
}
WRIT -,+0,�ļ��ѵ���...
_END

//#################################################
//����WinSXS--��������
//#################################################
_SUB winsxs1
//��ȡ�����ļ�
ENVI ����=%CurDir%\Bin\sxs\sxs1.txt
ENVI Ŀ¼=%~1\Windows\WinSXS
//��������ļ��Ƿ����
IFEX %����%,! 
{
	WRIT -,+0,�����ļ���ʧ��WinSXSû�о���
	EXIT FILE
}
//whileѭ����ȡ����
ENVI readline=1
READ %����%,%readline%,sxsfolder
LOOP $%sxsfolder%!=The_End,
{
	//ͨ���ɾ���ļ�
	IFEX %Ŀ¼%\%sxsfolder%,FILE %Ŀ¼%\%sxsfolder%_*
	CALC readline=%readline% + 1
	READ %����%,%readline%,sxsfolder
}
WRIT -,+0,WinSXS�������...
_END

//#################################################
//����WinSXS--��Ⱦ���
//#################################################
_SUB winsxs2
//��ȡ�����ļ�
ENVI ����=%CurDir%\Bin\sxs\sxs2.txt
ENVI Ŀ¼=%~1\Windows
//��SXS������ΪSXSBak
FILE %Ŀ¼%\WinSXS>>%Ŀ¼%\WinSXSBak
MDIR %Ŀ¼%\WinSXS
//��������ļ��Ƿ����
IFEX %����%,! 
{
	WRIT -,+0,�����ļ���ʧ��WinSXSû�о���
	EXIT FILE
}
//whileѭ����ȡ����
ENVI readline=1
READ %����%,%readline%,sxsfolder
LOOP $%sxsfolder%!=The_End,
{
	//ͨ����ƶ��ļ�
	IFEX %Ŀ¼%\WinSXSBak\%sxsfolder%,
	{
		FILE %Ŀ¼%\WinSXSBak\%sxsfolder%_*->%Ŀ¼%\WinSXS\
	}!
	{
		WRIT -,+0,���ִ���%sxsfolder%
	}
	CALC readline=%readline% + 1
	READ %����%,%readline%,sxsfolder
}
WRIT -,+0,WinSXS�������...
_END

//#################################################
//����--ȥ�������汾
//#################################################
_SUB exportonly
//���ļ�
BROW Ŀ��,&%Desktop%\install.wim,�뱣�����յ�WIM/ESD����,WIM����|*.wim|ESD����|*.esd|,0x02090002
//��ȡ��׺
RSTR ��׺=3,%Ŀ��%
//�жϺ�׺ʹ�ò�ͬ�ĵ�������
IFEX |%��׺%=wim,
{
	EXEC =%CurDir%\Bin\wimlib-imagex.exe export %CurDir%\DVD\sources\install.wim %1 "%Ŀ��%" --compress=LZX
}
IFEX |%��׺%=esd,
{
	EXEC =%2 /Export-Image /compress:recovery /CheckIntegrity /SourceImageFile:%CurDir%\DVD\sources\install.wim /SourceIndex:%1 /DestinationImageFile:"%Ŀ��%"
}
_END