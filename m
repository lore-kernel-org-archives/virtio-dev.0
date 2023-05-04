Return-Path: <virtio-dev-return-12551-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5056C7EE21
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 14:31:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4588271C92
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 14:31:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 339DD9866B9
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 14:31:48 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 261D29866B1; Thu,  4 May 2023 14:31:48 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 122FC9866B2;
	Thu,  4 May 2023 14:31:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKQ2p0wVyBkJ234l/IagjHz27NbC7s+oQr13qrtQMrdPalsY+xjsp8BleMmfGl9uCuptGPixEpkLof7vKvZJf8uIQRQngSXdrWQE7SLC+CK0sCDKd2guwY/kA3OFgEurLxiJPSVtjD1W+J2OjvIaczdC9yDks9KfOhDboHretndzS0Dnu1LC/BQX0QKmLp3ZwJLHlUO0AYKKBBE0jpCFw2Lvi6cyi3X2SyOnnZ/CfRxq52sof+B5bKDoT9QPultmvaS9gFKpsTeGxHJny3QPchlCKKuJa9Q1ZSVMeV+Q7+aeGhA6avx/2wuMJjgEVQznAhDBrQJSkVhBFFwXrJNPdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kK0qMbIvmogW75UJ3MJb3WYtmc9X308MvKEqWdFElGM=;
 b=LcXYeiaBK/FrpECr4m+H63jbmdx/oMlBdyRsVKjMuAPguGVMik2k2u0gPYfOKcJg1+djbGLxDTxPGGgLwevqt5n1C04wuxn7kE7B9WohzgcCvCZZl4nYcaLvp4rIqPfQPvqbcjO2VHHQrPouvOGS+qZIkEjHxzEyR0hPz/vpAnMntK7NyjziZ0syv2+uIn0X05EH1yBTojkq/5jT+9/oKDnqbdeeIvXSLRfyhkc0LjCT+37jdVtm5OLHcyTb0fIB4UPI5AGpyN4mirOV1rmUGcAwXJG6NeyxT3oCIFLAL5QQWK3MySw3tsbSOHDWc3A/avlKrgFBvSAFb5FE+TzBUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
From: David Edmondson <david.edmondson@oracle.com>
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com,
        virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: sgarzare@redhat.com, pasic@linux.ibm.com,
        virtio-comment@lists.oasis-open.org, shahafs@nvidia.com,
        Parav Pandit
 <parav@nvidia.com>
In-Reply-To: <20230504022959.547025-12-parav@nvidia.com>
References: <20230504022959.547025-1-parav@nvidia.com>
 <20230504022959.547025-12-parav@nvidia.com>
Date: Thu, 04 May 2023 15:31:35 +0100
Message-ID: <m2o7n04188.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0475.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::31) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|MW4PR10MB6557:EE_
X-MS-Office365-Filtering-Correlation-Id: ad1de65e-7f78-48ec-e0c4-08db4cac4694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/NWrH+rTaz4w8Bc9wKiWbIBhkVsyEX4BddXm/vqeaDtG+dFzoKdCjBLrySEtuHFQ/WExC/fcCzB+uyyjwO5vkyX3NHk/ai6gX0fzrOB9papkYl96O6ybbgSZ4ymBi0xtuqlLjSvnoWbxm7lEk4vZUAVi1DC33YipN/x7Zr+CAAwXKNCrcn5Q6V3YRxc4ITO/swEACnrr+xwE6x+/SzojcIjAgLLbELNYVMF0EzLyhfNaV3vKJ5cTGJiFcXFFrhVryimMM23Rlzu2+SC42ThjunPZoiApxYqbO9tHRcbLS8ZyRi5wmm7eZSHMqfimY8vubOjLZjn8oT1RkrpibZxk4P0xBv+LYa7t58DkQLPD+Dy02ykpgoL6OfjXpMlC+mO50ny5PIXJA/a7EwtGsjqlSl2LO/3+q1VLXgfquZbbP56UBjXxO3X2iflGYxwRToF56Vjz3etypNmWC8WtSR1onddrHbeP326jY321iLogsLsGXQmtRVIKMEwBrmuBKik9/YXU6lF3+oDf3xo2yTJtzxuCx74t0cDWc6QnNhusDJc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4926.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199021)(6512007)(2906002)(2616005)(186003)(44832011)(83380400001)(6506007)(26005)(15650500001)(478600001)(5660300002)(66476007)(38100700002)(66556008)(66946007)(966005)(8676002)(8936002)(41300700001)(6486002)(6666004)(36756003)(316002)(86362001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ClDlLFsquj3fyqS7JeVskduHSrHxUAo95uMSCPBLAv6hlvD/8znHsWUWrbq3?=
 =?us-ascii?Q?T0dbMosg9Dd8LlpwrS5aAk6461sXFytulhFqhtnIcdYBjFlGwBJ4K7nmf00i?=
 =?us-ascii?Q?4g/rPuGXGPgoP1r9JR7NmMUj5OIQymvZ0XzJkFWV7pldCRyqmWgYySMhUj6E?=
 =?us-ascii?Q?rR5aLxiomTC0gs0LnmDPzyY/WCJZr6mHdUfkhkd6e64k5WhNuUv+ikgfpcCu?=
 =?us-ascii?Q?hbq6x36onHQ/1bkcrQGMBNBMBpE2sAiDynPTvI9hqIsNe1ZKBnDtxNEO1wcQ?=
 =?us-ascii?Q?V25qKE4272vscWhUVDAMlDrmrTqqXz80ofF2PyImEis/RcpKl1QZ9dOYWkkP?=
 =?us-ascii?Q?gkdASDPw86fq7EwsufhToYxstuNiJ2YhX/mAQoE/26+6oIb5mwsmTnNo13sD?=
 =?us-ascii?Q?IXpFydpn1CSymRlxmZt8qBRhVJ03b/cVDG/rbXhVyYE0oUWIjFIjFpfaftOm?=
 =?us-ascii?Q?b4PmOe1jM/YEErVeV9H1QzcydL07HwGBxcPGhDixsSV6s0OUhRr1C9gSwSAw?=
 =?us-ascii?Q?LFneAuaPFDEnBirbRNDHHOtxlr/Mkni6twSfkDdD7CCTyjT072JPqCJZNNbU?=
 =?us-ascii?Q?Bs6GHF7AEo9aHt/ATT7rhUDL+Joagu8zZU+c7X9G5VUVWH9AI5gTMxIeMh5k?=
 =?us-ascii?Q?LiLRuqQ1fXkAdbJJdc/t+s6wW5jwZEfQSGBabMro0PnYizrmfFRjEB8jA192?=
 =?us-ascii?Q?HqXTp/g/MPKv5Kx59+/rynfkojutZ0SuLsiEvrMXJCh7cy74VfT6jDQQrqya?=
 =?us-ascii?Q?hnOmJ2wV17ns+fZryIQ6dUR6ZFnHX9tuaXx2U3P9eaIpeYOkoKuSTVdKLu+J?=
 =?us-ascii?Q?0kXE+EqgkFsRWbwtlEdDpDv46wIW1vKl+zyn2zz8WqgFNg9Iq6knt9vei23Y?=
 =?us-ascii?Q?0vp5h0Tt6IjCrmbMazjPGklnuLLOVHuvSaTPqT1hhg3xBFlCv9SUwLN7heMN?=
 =?us-ascii?Q?u+qQYG7Ksye+g+JSZnpMl4EkOKFYyAnsiDmx38d044+R6bs3+EGwV67QCpAn?=
 =?us-ascii?Q?grKofM2MeG41QcFxa07CMqO58UmgG/03Q9dfky2yg9hS94duUQb1e6OtNctz?=
 =?us-ascii?Q?U1p2yDE3EkcTFwwNSWiLPfj5wSaK1FB5/2GLNhHl1X869ojvIH5++hmVLtKR?=
 =?us-ascii?Q?ynmeWXq/7al4CjQkR4fmnRguNJ6vLh80TqniYEmdc19xP0RmnU/EUzHNpThd?=
 =?us-ascii?Q?YD+mOH1E+4W3ZT2sFjKhuALKYsL8n2BXPliLjHegafh+Z0HfPbk6iQHZCRTM?=
 =?us-ascii?Q?t15WgzRSLkMLW/1QetRR/p6NlLZoxIhU0m6wG5IOuUq/LktIEIdKJRIjoiWW?=
 =?us-ascii?Q?LSgKoFqd1G4XtLUY+whSCebEPAsem9Z0LdnBIC8urXLmCc6GHjIELtNc0LqW?=
 =?us-ascii?Q?Y9+/ST1MdcormihsDN7xeD2Fc1JoXuRpo2tGBKZJ56lNgocWz0OoxcUTUOTj?=
 =?us-ascii?Q?G8WFnQq1ZKI+QcHiwPE+C++/ZE05V/Kiv2sMrAE+P46XgHkrlTIEyz24EiEH?=
 =?us-ascii?Q?8dsgtNuc27ngeelcuqtWyiJtPq1lZpm8kVSZG1SNacVVcKbqaWqi510q4KCv?=
 =?us-ascii?Q?KxwMpWcHB5uCgPsniz8kChuOIvhPh/ZLWnGVpgWP6aYFiSiZ731KgEhh/XK/?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lv9J3ijGdFUC877uxfC09NzHxeRXVHl9KfiYA8Zus1I3dxztlT3wQXWqw/5c6Ibu+hUXqTePP4N8fINU2pqg4/ssd80pLCG2P/o+CY/j7zi9283Jk/UIugegM+o/ahfAfGhLftHq9Cx0pZXIFtNFvoa+a1GkP2B7br5NnlADwupGraHZb68itNgNeXoWm9WARPqxD4qq7Yu8i7xxTRRM+kKyDH+P9njwwDAel2+XMdGUGG//FVKe+Vt/MSx21EO7dB1c2e6QuoXoVFIfyrCdqLKNthWIR0TLpS++SO1lmZ4t0OvWqPt4+SvNOtQ+SHrG1pSxWiZPwms5eW+mVePrxK3YmXHOVHIGJxD9siKxYz09In0xId2oO/DItFN7bkKUQrKkkj/FPDrGXZYqL35UJ/KfSJXJwlvDTEQS9w056BpLlfwmsi1L9H8JLIAQkXhZ4+JOLY5kgKKYaLz7KWtSygakkW6cUINcxva1zII13i6pXvlLz1Tikre2mw8l876mM3h2c0Mz7gxc3k3tGECbquWxqQ+aZwAfGtC6SoPAALG+MVCdilOzPAVcpHpHDa0pz+VuiP5Csmw7bd1M2KJwqEZzMWJee5o5HEQqQsFJx9cbU0f1PGlpOsqi4cGKt4m7bG/8v77wqJr1K++wHEn2wN/328U6/FBazwFu9L2n369t/QE+eLuyQGJYFIumMqz8YRQ0WpeZcEebFQdpoYLuXf3ftPboZgKagh35Zy+GlL+TPUT2ns4a2Uu0V5c81bAsmfS9oPcNj4mwyLaqHiYEb07KTN/7pfkr96//y5LySS7Nzi654w7tlCYrVzTF/TITSTqlerWnpKbqOWuEX051karHyXlPjiR16yNeRoEmvppWyEEJE9o/w9hdv0WurUCF
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1de65e-7f78-48ec-e0c4-08db4cac4694
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 14:31:40.7545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T+e+vvJGzzfs7VLYcFq8EfM1fPU4PCr7vMX4XZdgpfFjIEsKiyes6Jefi8gBGH+O8+rkRsn/0BhOifbbPJmOCBVSYnSsVVIf16IZsKfkYak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6557
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_10,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305040119
X-Proofpoint-ORIG-GUID: z6_eXeLxG5QmRwp8MWQ00zD5UMowwxz7
X-Proofpoint-GUID: z6_eXeLxG5QmRwp8MWQ00zD5UMowwxz7
Subject: [virtio-dev] Re: [PATCH v16 11/11] virtio-net: Update vqn to vq_index for cvq cmds

Parav Pandit <parav@nvidia.com> writes:

> Replace field name vqn to vq_index for recent virtqueue level commands.
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
> Signed-off-by: Parav Pandit <parav@nvidia.com>
>

Reviewed-by: David Edmondson <david.edmondson@oracle.com>

> ---
> changelog:
> v12->v13:
> - new patch
> ---
>  device-types/net/description.tex | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/device-types/net/description.tex b/device-types/net/description.tex
> index 83bdaef..3030222 100644
> --- a/device-types/net/description.tex
> +++ b/device-types/net/description.tex
> @@ -1560,7 +1560,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  };
>  
>  struct virtio_net_ctrl_coal_vq {
> -    le16 vqn;
> +    le16 vq_index;
>      le16 reserved;
>      struct virtio_net_ctrl_coal coal;
>  };
> @@ -1574,7 +1574,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  
>  Coalescing parameters:
>  \begin{itemize}
> -\item \field{vqn}: The virtqueue number of an enabled transmit or receive virtqueue.
> +\item \field{vq_index}: The virtqueue index of an enabled transmit or receive virtqueue.
>  \item \field{max_usecs} for RX: Maximum number of microseconds to delay a RX notification.
>  \item \field{max_usecs} for TX: Maximum number of microseconds to delay a TX notification.
>  \item \field{max_packets} for RX: Maximum number of packets to receive before a RX notification.
> @@ -1587,7 +1587,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  \begin{itemize}
>  \item For commands VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET, the structure virtio_net_ctrl_coal is write-only for the driver.
>  \item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET, the structure virtio_net_ctrl_coal_vq is write-only for the driver.
> -\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET, \field{vqn} and \field{reserved} are write-only
> +\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET, \field{vq_index} and \field{reserved} are write-only
>        for the driver, and the structure virtio_net_ctrl_coal is read-only for the driver.
>  \end{itemize}
>  
> @@ -1596,9 +1596,9 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  \item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: use the structure virtio_net_ctrl_coal to set the \field{max_usecs} and \field{max_packets} parameters for all transmit virtqueues.
>  \item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: use the structure virtio_net_ctrl_coal to set the \field{max_usecs} and \field{max_packets} parameters for all receive virtqueues.
>  \item VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET: use the structure virtio_net_ctrl_coal_vq to set the \field{max_usecs} and \field{max_packets} parameters
> -                                        for an enabled transmit/receive virtqueue whose number is \field{vqn}.
> +                                        for an enabled transmit/receive virtqueue whose index is \field{vq_index}.
>  \item VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET: use the structure virtio_net_ctrl_coal_vq to get the \field{max_usecs} and \field{max_packets} parameters
> -                                        for an enabled transmit/receive virtqueue whose number is \field{vqn}.
> +                                        for an enabled transmit/receive virtqueue whose index is \field{vq_index}.
>  \end{enumerate}
>  
>  The device may generate notifications more or less frequently than specified by set commands of the VIRTIO_NET_CTRL_NOTF_COAL class.
> @@ -1608,12 +1608,12 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  with two pairs of virtqueues as an example:
>  Each of the following commands sets \field{max_usecs} and \field{max_packets} parameters for virtqueues.
>  \begin{itemize}
> -\item Command1: VIRTIO_NET_CTRL_NOTF_COAL_RX_SET sets coalescing parameters for virtqueues having vqn 0 and vqn 2. Virtqueues having vqn 1 and vqn 3 retain their previous parameters.
> -\item Command2: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vqn} = 0 sets coalescing parameters for virtqueue having vqn 0. Virtqueue having vqn 2 retains the parameters from command1.
> -\item Command3: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vqn} = 0, the device responds with coalescing parameters of vqn 0 set by command2.
> -\item Command4: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vqn} = 1 sets coalescing parameters for virtqueue having vqn 1. Virtqueue having vqn 3 retains its previous parameters.
> -\item Command5: VIRTIO_NET_CTRL_NOTF_COAL_TX_SET sets coalescing parameters for virtqueues having vqn 1 and vqn 3, and overrides the parameters set by command4.
> -\item Command6: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vqn} = 1, the device responds with coalescing parameters of vqn 1 set by command5.
> +\item Command1: VIRTIO_NET_CTRL_NOTF_COAL_RX_SET sets coalescing parameters for virtqueues having index 0 and index 2. Virtqueues having index 1 and index 3 retain their previous parameters.
> +\item Command2: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vq_index} = 0 sets coalescing parameters for virtqueue having index 0. Virtqueue having index 2 retains the parameters from command1.
> +\item Command3: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vq_index} = 0, the device responds with coalescing parameters of vq_index 0 set by command2.
> +\item Command4: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vq_index} = 1 sets coalescing parameters for virtqueue having index 1. Virtqueue having index 3 retains its previous parameters.
> +\item Command5: VIRTIO_NET_CTRL_NOTF_COAL_TX_SET sets coalescing parameters for virtqueues having index 1 and index 3, and overrides the parameters set by command4.
> +\item Command6: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vq_index} = 1, the device responds with coalescing parameters of index 1 set by command5.
>  \end{itemize}
>  
>  \subparagraph{Operation}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing / Operation}
> @@ -1663,7 +1663,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  
>  \drivernormative{\subparagraph}{Notifications Coalescing}{Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
>  
> -The driver MUST set \field{vqn} to the virtqueue number of an enabled transmit or receive virtqueue.
> +The driver MUST set \field{vq_index} to the virtqueue index of an enabled transmit or receive virtqueue.
>  
>  The driver MUST have negotiated the VIRTIO_NET_F_NOTF_COAL feature when issuing commands VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET.
>  
> -- 
> 2.26.2
-- 
"Can I take you out to the pictures, Joan?"

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

