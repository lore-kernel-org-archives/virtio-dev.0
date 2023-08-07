Return-Path: <virtio-dev-return-13479-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A437C001B0
	for <virtio-dev@archiver.kernel.org>; Mon,  7 Aug 2023 08:03:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E120175986
	for <virtio-dev@archiver.kernel.org>; Mon,  7 Aug 2023 08:03:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 93045986466
	for <virtio-dev@archiver.kernel.org>; Mon,  7 Aug 2023 08:03:56 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7D3B1984033; Mon,  7 Aug 2023 08:03:56 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6517C98612D;
	Mon,  7 Aug 2023 08:03:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPmvNcrawvajD4XFXZHxv2dRqmZFyv/wKxk7VTCt81NtQRixm6y8HsEy8UKaCZuMozYpJTazobRU7CADnTNSeu4yxSNEs1W9h+pM5Z4yY26kGDBTfF7VZtjmhTd7GX3VPe6tK+KNjoLc0ni/yKUIgO/e6hW2xv/tlAJqXNNFxmeyCGJxr64RzJeI9uIDJXcV9aJQombFtj7Sfr58TP6Tx+WRhj1d/rqWbenfsmokwXm2JFwR/7//KF15hPDF5AAvCxnFraLCcmJHFx1U3YjPaOwChtNthCP5vdtRU3xGS+EtPzgzPwNOHP3/QBTGBtQZiTU8SFWfOFxLEtERoQxyxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7F/9NNuWNTwwEFO6khWxFD5mahqaikPblKD3QF0OyGk=;
 b=QLn233w0+zzlFypL0MzEGUvRF52EJhFGzkhH5Y+x9ETJODEwvZHrkzEN8L1X7CBInKmw88+JgOXMq8X8y1saAiQjiQRz6Wa3wcBfkn66wpIubJJbOp+fqU7JY6nschqd5vJBzkPdDvfvZ2+EULnnqC7BamCi3K0QMEY8zbdI1f/N2lHqJ/j1DOmzURnLSHVFQyOXqXXtbyxPQVWEM2HYNKVuBqx8wfp+L2qNPbTIdx/AepEeu7W4rrOV08Aph4Vb2phfmAdY5JhfT6ODxGi65/JNxI2JAYI/V6I8gZE27r7fBa6DFvdS0Zo8ZDMGgzfrw5LfNgrnvWqpQeINDu0N5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
From: David Edmondson <david.edmondson@oracle.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtio-dev@lists.oasis-open.org, jasowang@redhat.com,
        "Michael S.
 Tsirkin" <mst@redhat.com>,
        Parav Pandit <parav@nvidia.com>, virtio-comment@lists.oasis-open.org
In-Reply-To: <20230731072722.70310-1-xuanzhuo@linux.alibaba.com> (Xuan Zhuo's
	message of "Mon, 31 Jul 2023 15:27:22 +0800")
References: <20230731072722.70310-1-xuanzhuo@linux.alibaba.com>
Date: Mon, 07 Aug 2023 09:03:37 +0100
Message-ID: <m2h6pbnusm.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0449.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::22) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|CYXPR10MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: 96c6a4b5-da10-429d-8180-08db971cd12c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6cIUc4qk0YQmK7Nogag6WlBKk9a0tOxc05P7RAoLTwHGMlt4yljzwjJOJoaqvePJK//wYrGY6w2Zn7+ChQNmM+1IrkjrY95XmPYvUC4woWPjhNeOEhJRzsT5wAYVCXd4+hI4GJbBqbqfY9sYBg7twfwJwfObuFhF1neLiQWASpMFFlvbtEIkdCVOvWdabC6m96I9BvgHaMUzsIn622fWwwgEwVL9pEX9fR7tOhtuBBiKws66/t/YA1K8iPVOeyxU1QYK/HgHsNhF2Jd9OMIHphpr/pRPswhqd9Y8lKuawW5VngLiJxRFQIwn6JhX+SQ5dyzxpPumstc0FD/Ylh0/DMMMKF/hBXHTTGFDvG57sNiIMFYwUl6TdlF3ebSrzX103puyrdBhXqmDbXTvEzXuMEcCsLQ5/qaWecjDJAug3k0o43zNnV0nJbudfUD+WAx9o02GBoGMNZautx9Qqv+RHGt8lTAiAS2st+BUjhfQHOBsXkXJwvd5vg0Vz8Otv9KnPNINDW7DlwkME7HeJAFU07+28A2KPKpJPNrBcTbYDnk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4926.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199021)(1800799003)(186006)(66899021)(2616005)(6486002)(6666004)(6512007)(478600001)(86362001)(966005)(26005)(36756003)(6506007)(41300700001)(316002)(30864003)(8936002)(5660300002)(44832011)(8676002)(54906003)(4326008)(2906002)(6916009)(66946007)(66556008)(66476007)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?uKWRYPBA++D80piIyNfVbxIjm7v0ONMCUKekKpiKinnGCMd6J/OPeCCL/n7q?=
 =?us-ascii?Q?a9v/Es9Il7ACM7Gv4iCldWWYbsPDGL8MN6ao9GxdrLbdoho4ZwKm/Vc0nUE7?=
 =?us-ascii?Q?/yzJYBIlopCL7OnddkqIRs0/LdphwdYbRIiHYWkmOApT8h0gA/5qMFjNAyEy?=
 =?us-ascii?Q?kkohfK3gHuqWh+WndRoUn7TP50pgruclYUZL5RQhvtz+O6pcwgcYx/FqCnsl?=
 =?us-ascii?Q?wC9V2hxIQTMLXeFwpgSOKMUMIeTHdTKiHQDv64vHOk67DPluYF9xtfpqFyGC?=
 =?us-ascii?Q?cTyMwCgTi3p7XleJUD6bopzJbnXN0zYjGL8SGXxIQRgq3cREiWDjihFUbDVq?=
 =?us-ascii?Q?DEU/m7Zr05PX9EZUZVxSdM4ccdY8FcVpWX9KEF51iFVKliFNd47pbRq3z4nx?=
 =?us-ascii?Q?m6WoMeBTcjzBENE3lp195XR83APt78o2XYL5VTrmn4yckbVRKVQDh4FzvG5u?=
 =?us-ascii?Q?rqQL82xGBV4wSiyjFmyWPlOm5WhjT50QqRfsoRiojhxjm9l6G4RoyvsdI4vv?=
 =?us-ascii?Q?13jW/d6Pzz96fSLSePPGI5G8dite5JV3rOxOiePzJGAvj6UMEOpUGLfQ3RyE?=
 =?us-ascii?Q?ElOaIABvpgxyANaHN+Kb/8kO6bJ4quHnUsaCtr9Gsivy5bbc1Z0aB1jZfj3g?=
 =?us-ascii?Q?t68WPo5gRwygsD2bgoY/iN/ScQQ9GW3l1gKpKreHJND8F6SyXU37rZ4VbUIX?=
 =?us-ascii?Q?El8tvNpCqszadxGGWtUG9yLdRtf+fMu7C4jFCJiCQcNzcwYDPrvF/tk4d7Mz?=
 =?us-ascii?Q?rHSjv+U+i5QYG2E2vh641bvlPzbiV2b6s+sgUhbo7qoCYgznAsqsZLfnPEZG?=
 =?us-ascii?Q?GP44mscxs9KmeTNOcFAqZ+TSag6XzLAIBxgjJMfoNafzG1+RFCM8fv4B0r6f?=
 =?us-ascii?Q?nJc63oKxKLa9FC+TUFliGAZJKsXA/Qgkw+SQ79fE/fiBrGL1it3a/83Kpmvw?=
 =?us-ascii?Q?xo94i6ErWIZgPske2ZISWxBesdx4VnBDpqny5RGUj7x6SmFbOEwjguK00inz?=
 =?us-ascii?Q?G9ZuxtZk0Tg5+uy676mExvnxRDWDAPjH7Syruk1LtNVV78hyrtdDUXH6w89R?=
 =?us-ascii?Q?tFcMIekD1+ewuNicSfQud8b4HbGi2NYcT5D/pB7VFJDTzJJ2WqDsv8icoUXG?=
 =?us-ascii?Q?Pyrf3Jkw5ZUYSsIsGuRwfQ+qIooGIo5PjqCMPl7/0Ct6hb/zt7OY2BckrARJ?=
 =?us-ascii?Q?ergGF2XJL45JEbwtIZLmCazRThn3mhhUmsuxokggeG6xMhoNBXhZIuVXC0yr?=
 =?us-ascii?Q?u8eu+e5lL+ITU/K7DuAhVlO9DsiwrbQxfIsXIuBF910eb8Y0mNJwk4hy7qEd?=
 =?us-ascii?Q?6naHaa2i1wDvLibL5rkaUBMVs00JKuguigAkJdGjkBNgx0w/ZDVijHp2Pugp?=
 =?us-ascii?Q?98CMf9BlGv3loG5LedC+fM8df+RZQedYN1DvoVmUfzgky1nHlWO7U9gN5wby?=
 =?us-ascii?Q?SYVKffinD76WyhJCd9ZS9IzJ840UPLCWqhz7kF4zIlPZ0PVeQd3MzFwJ1+qx?=
 =?us-ascii?Q?3ZW9q8x2Mnx2es2h3nUChz/tVfDa1EHCzpOKXXK8rSwqSTzvg6chq4uaacD1?=
 =?us-ascii?Q?8cMM2582Eye2GOTdvm4xGjIeZrUDWWNSiEeg3gnlo7tJUKa9o36OEDa3ahHm?=
 =?us-ascii?Q?KQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	f9TAZRxBhPhFh9C3UWt3wVVyfqFlCIBJK7DSLAIYTloJwLxZ0pEp5k/gCrpxWeqy2KwTDUVfb3huj5wReIe7pX2LGCVgIYErmEl5JmFSD8XBvnlMsg1gLx3lslZSuQZm3xUe9NVGNjVsZaoAT6M5D+ibGUkrmS5PpHL8Qvj1QbhlW9wCjB7c9VS/JnCqWkC8d/3YU37JKCkZ/jQ2Pa7n6dKnf8JINsASMfqVXWoQ7Zda0lhV4PnHsvx5aR4aK6gQ5g5ZB0WKwJTHYZtPV954Xp9+HanOFQoQHIM7yrW7ZuvcVjPk0BQ5JtMWsGCENKhXQEwHFmEReGYMsxBplSookUZ7o0UPY33LGBfF8bvy8PfkOB+HWOkFubkRGU5oOmWP6gVVwHgRaCKCTvlejVrKKkqy3JZR+NykHBW6vLUWlHgzqOyO+BMx9YIQtDkrdQjvAa5KlWRd4Nf0eJy27oLJ8X3EtimT0mHxBmls7lRW/2WQnDr/in9//gXziPLeyt+5btA9CNP2Rg3Ipqd33d8JKPBVEDEFJ33VGys2jc8B2ZNZ4nKf39e7t9DreNNvFbdviCESVM1YozatZEJLWF+9hy+wLYdrN2uo3DlwdoFMTfbhgCB2D+fATq4d7XltIxBUl5Pc3D8sv7B0b20IF4Y/x15tYh93XUKV+UTR1KNkWnQaw8Nt+r1RB80XSQDnX/jN7tWyC2xrBIQtkDVk1YzyBaHejRm0zTRFbOOaF2/k5YRAFX5w4/hAK/5uimJc2pvgjCrXhWiqdlEKnR9yfeQ2Zc0Rdi+tIxRKGAL5/gVaKP4esY4aDd1mFWTNE9jBM1Sf3KtA0XsjCNrvPJxUTeB/s8HaCKztOZmLUWmJjPOZxecz9mQLWs9nr0BtDTP7LOsq
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c6a4b5-da10-429d-8180-08db971cd12c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 08:03:42.8732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0fmE2Gh+1Zjx4P/7dvb/f3mNVIDXELjGqqcPzyzzogGL3GOhRERrh8WpukBy0h6a0fUynmmxXV5BBVKglEN+/82R4Gs/kiI+kFW1N8OYSag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7924
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_06,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308070074
X-Proofpoint-GUID: Rs-RsUEHegEiGZYCusQvN4OCW-Om5c26
X-Proofpoint-ORIG-GUID: Rs-RsUEHegEiGZYCusQvN4OCW-Om5c26
Subject: [virtio-dev] Re: [PATCH v14] virtio-net: support device stats

On Monday, 2023-07-31 at 15:27:22 +08, Xuan Zhuo wrote:
> This patch allows the driver to obtain some statistics from the device.
>
> In the device implementation, we can count a lot of such information,
> which can be used for debugging and judging the running status of the
> device. We hope to directly display it to the user through ethtool.
>
> To get stats atomically, try to get stats for all queue pairs in one
> command.
>
> If the feature is negotiated, the device must support all the stats
> listed in this commit. If we want add new stats in future, one new
> feature should be introduced.

Did you consider a query mechanism to avoid the need for a proliferation
of feature bits?

> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>
> v14:
>    * introduce supported_stats to config space
>    * add header(vq_index, size, type) to each reply stats
>    * add ref to the tx GSO
>
>  device-types/net/description.tex        | 365 +++++++++++++++++++++++-
>  device-types/net/device-conformance.tex |   1 +
>  device-types/net/driver-conformance.tex |   1 +
>  3 files changed, 364 insertions(+), 3 deletions(-)
>
> diff --git a/device-types/net/description.tex b/device-types/net/description.tex
> index 76585b0..fd7160a 100644
> --- a/device-types/net/description.tex
> +++ b/device-types/net/description.tex
> @@ -88,6 +88,9 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
>  \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
>      channel.
>
> +\item[VIRTIO_NET_F_DEVICE_STATS(50)] Device can provide device-level statistics
> +    to the driver through the control channel.
> +
>  \item[VIRTIO_NET_F_HASH_TUNNEL(51)] Device supports inner header hash for encapsulated packets.
>
>  \item[VIRTIO_NET_F_VQ_NOTF_COAL(52)] Device supports virtqueue notification coalescing.
> @@ -1156,6 +1159,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>          u8 command;
>          u8 command-specific-data[];
>          u8 ack;
> +        u8 command-specific-data-reply[];
>  };
>
>  /* ack values */
> @@ -1164,9 +1168,11 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  \end{lstlisting}
>
>  The \field{class}, \field{command} and command-specific-data are set by the
> -driver, and the device sets the \field{ack} byte. There is little it can
> -do except issue a diagnostic if \field{ack} is not
> -VIRTIO_NET_OK.
> +driver, and the device sets the \field{ack} byte and optionally
> +\field{command-specific-data-reply}. There is little the driver can
> +do except issue a diagnostic if \field{ack} is not VIRTIO_NET_OK.
> +
> +The command VIRTIO_NET_CTRL_STATS_GET contains \field{command-specific-data-reply}.
>
>  \paragraph{Packet Receive Filtering}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Packet Receive Filtering}
>  \label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Setting Promiscuous Mode}%old label for latexdiff
> @@ -1805,6 +1811,359 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>
>  Upon reset, a device MUST initialize all coalescing parameters to 0.
>
> +\paragraph{Device Stats}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats}

"Stats" is an abbreviation - in the prose it would be better to use
"statistics" consistently.

> +
> +If the VIRTIO_NET_F_DEVICE_STATS feature is negotiated, the driver can obtain
> +device stats from the device by using the following command.
> +
> +Different types of virtqueues have different stats. The stats of the receiveq
> +are different from those of the transmitq.
> +
> +The stats of a certain type of virtqueue are also divided into multiple types
> +because different types require different features. This enables the expansion
> +of new stats.
> +
> +At one time, the driver can obtain the stats of one or multiple virtqueues.
> +Additionally, the driver can obtain multiple type stats of each virtqueue.
> +
> +\begin{lstlisting}
> +#define VIRTIO_NET_CTRL_STATS         7
> +#define VIRTIO_NET_CTRL_STATS_GET     0
> +\end{lstlisting}
> +
> +To obtain device stats, use the VIRTIO_NET_CTRL_STATS_GET command with the
> +\field{command-specific-data} containing the virtio_net_ctrl_queue_stats
> +structure. The result is returned in the \field{command-specific-data-reply}.
> +
> +The following structure is used in \field{command-specific-data}:
> +\begin{lstlisting}
> +struct virtio_net_ctrl_queue_stats {
> +       struct {
> +           u16 vq_index;
> +           u48 padding;

u8 padding[6] ? Not sure that u48 is used anywhere else.

> +
> +#define VIRTIO_NET_STATS_TYPE_CVQ       (1 << 0)
> +
> +#define VIRTIO_NET_STATS_TYPE_RX_BASIC  (1 << 0)
> +#define VIRTIO_NET_STATS_TYPE_RX_CSUM   (1 << 1)
> +#define VIRTIO_NET_STATS_TYPE_RX_GSO    (1 << 2)
> +
> +#define VIRTIO_NET_STATS_TYPE_TX_BASIC  (1 << 0)
> +#define VIRTIO_NET_STATS_TYPE_TX_CSUM   (1 << 1)
> +#define VIRTIO_NET_STATS_TYPE_TX_GSO    (1 << 2)
> +
> +           u64 types;
> +       } stats[];
> +};
> +\end{lstlisting}
> +
> +The following structures are used in \field{command-specific-data-reply}:
> +\begin{lstlisting}
> +struct virtio_net_stats_cvq {
> +    le64 command_num;
> +    le64 ok_num;
> +};
> +
> +struct virtio_net_stats_rx_basic {
> +    le64 rx_packets;
> +    le64 rx_bytes;
> +
> +    le64 rx_notification;
> +    le64 rx_interrupt;
> +
> +    le64 rx_drop;
> +    le64 rx_drop_overruns;
> +    le64 rx_drop_busy;
> +};
> +
> +struct virtio_net_stats_rx_csum {
> +    le64 rx_csum_valid;
> +    le64 rx_needs_csum;
> +    le64 rx_csum_bad;
> +    le64 rx_csum_none;
> +};
> +
> +struct virtio_net_stats_rx_gso {
> +    le64 rx_gso_packets;
> +    le64 rx_gso_bytes;
> +    le64 rx_gso_packets_coalesced;
> +    le64 rx_gso_bytes_coalesced;
> +    le64 rx_gso_segments;
> +    le64 rx_gso_segments_bytes;
> +};
> +
> +struct virtio_net_stats_tx_basic {
> +    le64 tx_packets;
> +    le64 tx_bytes;
> +
> +    le64 tx_notification;
> +    le64 tx_interrupt;
> +
> +    le64 tx_drop;
> +    le64 tx_drop_malformed;
> +
> +    le64 tx_drop_busy;
> +};
> +
> +struct virtio_net_stats_tx_csum {
> +    le64 tx_csum_none;
> +    le64 tx_needs_csum;
> +};
> +
> +struct virtio_net_stats_tx_gso {
> +    le64 tx_gso_packets;
> +    le64 tx_gso_bytes;
> +    le64 tx_gso_packets_split;
> +    le64 tx_gso_bytes_split;
> +    le64 tx_gso_segments;
> +    le64 tx_gso_segments_bytes;
> +};
> +
> +\end{lstlisting}
> +
> +\begin{description}
> +    \item [vq_index]
> +        The index of the virtqueue to obtain the stats.
> +
> +    \item [types]
> +        This is a bitmask of the types of stats to be obtained. Therefore, a
> +        \field{struct stats} inside virtio_net_ctrl_queue_stats may instruct
> +        multiple stats replies for the virtqueue.
> +\end{description}
> +
> +\subparagraph{Controlq Stats}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats / Controlq Stats}
> +
> +The structure corresponding to the controlq stats is virtio_net_stats_cvq.
> +
> +\begin{description}
> +    \item [command_num]
> +        The number of commands including the current command.
> +
> +    \item [ok_num]
> +        The number of commands (including the current command) where the ack was VIRTIO_NET_OK.
> +\end{description}
> +
> +
> +\subparagraph{Receiveq Basic Stats}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats / Receiveq Basic Stats}
> +
> +The structure corresponding to the receiveq basic stats is virtio_net_stats_rx_basic.
> +
> +Receiveq basic stats doesn't require any feature. As long as the device supports

s/doesn't/does not/

> +VIRTIO_NET_F_DEVICE_STATS, the following are the receiveq basic stats.
> +
> +The packets described below are all steered to a specific virtqueue.

"steered" seems like a loaded term. Perhaps "The packets described below
were all presented on the specified virtqueue."?

> +\begin{description}
> +    \item [rx_packets]
> +        This is the number of packets received by the device (not the packets
> +        passed to the guest). The count includes the packets dropped by the
> +        device.
> +
> +    \item [rx_bytes]
> +        This is the bytes of packets received by the device (not the packets
> +        passed to the guest). The count includes the packets dropped by the
> +        device.
> +
> +    \item [rx_notification]
> +        The number of driver notifications received by device for this receiveq.
> +
> +    \item [rx_interrupt]
> +        The number of device interrupts for this receiveq.
> +
> +    \item [rx_drop]
> +        This is the number of packets dropped by the device. The count includes
> +        all types of packets dropped by the device.
> +
> +    \item [rx_drop_overruns]
> +        This is the number of packets dropped by the device when no more
> +        descriptors were available.
> +
> +    \item [rx_drop_busy]
> +        This is the number of packets dropped by the device when the device is
> +        busy.
> +
> +\end{description}
> +
> +\subparagraph{Transmitq Basic Stats}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats / Transmitq Basic Stats}
> +
> +The structure corresponding to VIRTIO_NET_STATS_TYPE_TX_BASIC is virtio_net_stats_tx_basic.
> +
> +Transmitq basic stats doesn't require any feature. As long as the device supports
> +VIRTIO_NET_F_DEVICE_STATS, the following are the transmitq basic stats.
> +
> +The packets described below are all from a specific virtqueue.
> +\begin{description}
> +    \item [tx_packets]
> +        This is the number of packets sent by the device (not the packets
> +        got from the driver).
> +
> +    \item [tx_bytes]
> +        This is the bytes of packets sent by the device (not the packets
> +        got from the driver).
> +
> +    \item [tx_notification]
> +        The number of driver notifications for this transmitq.
> +
> +    \item [tx_interrupt]
> +        The number of device interrupts for this transmitq.
> +
> +    \item [tx_drop]
> +        The number of packets dropped by the device. The count includes all
> +        types of packets dropped by the device.
> +
> +    \item [tx_drop_malformed]
> +        The number of packets dropped by the device, when the descriptor is in
> +        an error state. For example, the buffer is too short.
> +
> +    \item [tx_drop_busy]
> +        The number of packets dropped by the device, when the device is busy.
> +
> +\end{description}
> +
> +\subparagraph{Receiveq CSUM Stats}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats / Receiveq CSUM Stats}
> +
> +The structure corresponding to VIRTIO_NET_STATS_TYPE_RX_CSUM is virtio_net_stats_rx_csum.
> +
> +Only after the VIRTIO_NET_F_GUEST_CSUM is negotiated, the receiveq csum stats
> +can be obtained.
> +
> +The packets described below are all steered to a specific virtqueue.
> +\begin{description}
> +    \item [rx_csum_valid]
> +        The number of packets with VIRTIO_NET_HDR_F_DATA_VALID.
> +
> +    \item [rx_needs_csum]
> +        The number of packets with VIRTIO_NET_HDR_F_NEEDS_CSUM.
> +
> +    \item [rx_csum_bad]
> +        The number of packets with abnormal csum.
> +
> +    \item [rx_csum_none]
> +        The number of packets without hardware csum. The packet here refers to
> +        the non-TCP/UDP packet that the backend cannot recognize.
> +
> +\end{description}
> +
> +\subparagraph{Transmitq CSUM Stats}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats / Transmitq CSUM Stats}
> +
> +The structure corresponding to VIRTIO_NET_STATS_TYPE_TX_CSUM is virtio_net_stats_tx_csum.
> +
> +Only after the VIRTIO_NET_F_CSUM is negotiated, the transmitq csum stats can be
> +obtained.
> +
> +The following are the transmitq csum stats:
> +
> +The packets described below are all from a specific virtqueue.
> +\begin{description}
> +    \item [tx_csum_none]
> +        The number of packets that didn't require hardware csum.
> +
> +    \item [tx_needs_csum]
> +        The number of packets that required hardware csum.
> +
> +\end{description}
> +
> +\subparagraph{Receiveq GSO Stats}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats / Receiveq GSO Stats}
> +
> +The structure corresponding to VIRTIO_NET_STATS_TYPE_RX_GSO is virtio_net_stats_rx_gso.
> +
> +If one or more of the VIRTIO_NET_F_GUEST_TSO4, VIRTIO_NET_F_GUEST_TSO6, or
> +VIRTIO_NET_F_GUEST_UFO have been negotiated, the receiveq GSO stats can be
> +obtained.
> +
> +GSO packets refer to packets passed by the device to the driver where
> +\field{gso_type} is not VIRTIO_NET_HDR_GSO_NONE.
> +
> +The packets described below are all steered to a specific virtqueue.
> +\begin{description}
> +    \item [rx_gso_packets]
> +        The number of the GSO packets received by device.
> +
> +    \item [rx_gso_bytes]
> +        The bytes of the GSO packets received by device.
> +
> +    \item [rx_gso_packets_coalesced]
> +        The number of the GSO packets coalesced by device.
> +
> +    \item [rx_gso_bytes_coalesced]
> +        The bytes of the GSO packets coalesced by device.
> +
> +    \item [rx_gso_segments]
> +        The number of the segments that make up GSO packets.
> +
> +    \item [rx_gso_segments_bytes]
> +        The bytes of the segments that make up GSO packets.
> +
> +\end{description}
> +
> +\subparagraph{Transmitq GSO Stats}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats / Transmitq GSO Stats}
> +
> +The structure corresponding to VIRTIO_NET_STATS_TYPE_TX_GSO is virtio_net_stats_tx_gso.
> +
> +If one or more of the VIRTIO_NET_F_HOST_TSO4, VIRTIO_NET_F_HOST_TSO6,
> +VIRTIO_NET_F_HOST_USO or VIRTIO_NET_F_HOST_UFO options have
> +been negotiated, the transmitq GSO stats can be obtained.
> +
> +GSO packets refer to packets passed by the driver to the device where
> +\field{gso_type} is not VIRTIO_NET_HDR_GSO_NONE.
> +
> +The packets described below are all from a specific virtqueue.
> +\begin{description}
> +    \item [tx_gso_packets]
> +        The number of the GSO packets sent by device that are not split to small
> +        packets.
> +
> +    \item [tx_gso_bytes]
> +        The bytes of the GSO packets sent by device that are not split to small
> +        packets.
> +
> +    \item [tx_gso_packets_split]
> +        The number of the GSO packets that been split to small packets.
> +
> +    \item [tx_gso_bytes_split]
> +        The bytes of the GSO packets that been split to small packets.
> +
> +    \item [tx_gso_segments]
> +        The number of segments split from the GSO packets.
> +
> +    \item [tx_gso_segments_bytes]
> +        The bytes of segments split from the GSO packets.
> +\end{description}
> +
> +\devicenormative{\subparagraph}{Device Stats}{Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats}
> +
> +If virtio_net_ctrl_queue_stats is incorrect (such as the following), the device
> +MUST set \field{ack} to VIRTIO_NET_ERR. Even if there is only one error,
> +the device MUST fail the entire command.
> +\begin{itemize}
> +    \item \field{vq_index} exceeds the queue range.
> +    \item \field{types} contains unknown types.
> +    \item The type of vq does not match \field{types}. E.g. the driver tries to query
> +        receiveq stats by the index of a transmitq.

How would a device detect this, given that the bits used to express the
statistics type overlap?

If I ask for TX_CSUM on an RX queue, I'm going to get the RX_CSUM stats
and the device cannot be aware of the discrepancy.

This might be better as:

\item One or more of the bits present in \field{types} is not valid for
    the specified virtqueue.

> +    \item The feature corresponding to the specified \field{types} was not negotiated.
> +    \item The size of the buffer allocated by the driver for \field{command-specific-data-reply}
> +        is less than the total size of the stats specialed by
> +        \field{virtio_net_ctrl_queue_stats}.
> +\end{itemize}
> +
> +The device MUST write the requested stats structures in
> +\field{command-specific-data-reply} in the order specified by the structure
> +virtio_net_ctrl_queue_stats. If the \field{types} instructs multiple stats, the
> +replies order by the type value from small to large.

How are the multiple replies padded? "There is no additional padding
between structures." would be sufficient, I think.

> +
> +\drivernormative{\subparagraph}{Device Stats}{Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats}
> +
> +When a driver tries to obtain a certain stats, it MUST confirm that the relevant
> +features are negotiated.
> +
> +\field{types} in struct virtio_net_ctrl_queue_stats MUST correspond to the vq
> +specified by \field{vq_index}.
> +
> +The \field{command-specific-data-reply} buffer allocated by the driver MUST be
> +able to hold all the stats specified by virtio_net_ctrl_queue_stats.
> +
> +When the driver reads the replies, it MUST read
> +\field{command-specific-data-reply} one by one based on the \field{types}.

Not clear why this is here? The driver should be able to consume the
result however it chooses.

> +
>  \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
>  Types / Network Device / Legacy Interface: Framing Requirements}
>
> diff --git a/device-types/net/device-conformance.tex b/device-types/net/device-conformance.tex
> index f88f48b..a0c63d6 100644
> --- a/device-types/net/device-conformance.tex
> +++ b/device-types/net/device-conformance.tex
> @@ -15,4 +15,5 @@
>  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) / RSS processing}
>  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
>  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Inner Header Hash}
> +\item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats}
>  \end{itemize}
> diff --git a/device-types/net/driver-conformance.tex b/device-types/net/driver-conformance.tex
> index 9d853d9..2f1c674 100644
> --- a/device-types/net/driver-conformance.tex
> +++ b/device-types/net/driver-conformance.tex
> @@ -15,4 +15,5 @@
>  \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) }
>  \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
>  \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Inner Header Hash}
> +\item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats}
>  \end{itemize}
> --
> 2.32.0.3.g01195cf9f
>
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
>
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
>
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/
-- 
Tonight I'm gonna bury that horse in the ground.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

