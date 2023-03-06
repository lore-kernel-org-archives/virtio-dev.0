Return-Path: <virtio-dev-return-11452-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3839C6FD1B
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 17:01:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 30E6FC6111
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 17:01:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 262A29866C8
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 17:01:02 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 19F2E9866BF; Mon,  6 Mar 2023 17:01:02 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 05FBF9866BA;
	Mon,  6 Mar 2023 17:00:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CjHlG+uVCTaFBZNmAtABtiqlAzzp8zkOG+k/3zVWHJHRtmMfJrM5URQi2Ye1PwG/yBFl3qB6SE39RDzQPeTEjt0a7f83lNyb18p9v4/UDdXcqzrotWir0FvbbkMBOBg4wXLWNCOdKzDai7lDYcEqGKi5FcSagBTMiwUVeH1Zle15UKB4R/PyHFa9j6jX/eJxjOEnDmVC2vPKYNUM4Q2vry5jSqDbB3+71LYm+GwxiRl4v7+FjcarMAZruuUp/AJym43mTb74397yS3M4TRzzpED8g7Kloe64yOJ1qYCNznsJ7jyz9tAUvahvh6aAXV+8FuSRHusnpkqcAOoXpOEAFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MF5bUkhbDvFvcjNWl8sywhDaDU7t4O6Ns2/DWvFzVHc=;
 b=mkVktfwe6hQs6L9Z3pNcJXUCXepbJolSKQVlMq0DQHkqKX38V7y/s5TzrjhVGmFDuO4DGoLakeJAFY+jyHybxNntP2aqDtYcBPNW/ndNL7T3cNUsnWM99HML5gblDUU4ZZ2BN8S5qyMiLlv0+GBxRwUGd+6Emoj0A2jbHocGVdkrylQiZmm5BKbEfKWBfqiqubLZDHQyAfkZ6z+UvVKPjwNwAxYrclYKSLPHT86/+3//hyTRNCyjRJOcs/HGni/j8z43wPZ+vT/5ixO1bzwbn0zthuWNx1wQqLKFabnjsZjlCoLwF8Au/r4oi3b+75Qz+vVuYVOZ8hnN7QqjDYmrdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
From: David Edmondson <david.edmondson@oracle.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org,
        virtio-dev@lists.oasis-open.org, jasowang@redhat.com, mst@redhat.com,
        cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com,
        nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
        pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
        Parav Pandit
 <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <2d232eba17d75c5dad2db17dc297f34a3612c33e.1677761896.git.mst@redhat.com>
References: <cover.1677761896.git.mst@redhat.com>
 <2d232eba17d75c5dad2db17dc297f34a3612c33e.1677761896.git.mst@redhat.com>
Date: Mon, 06 Mar 2023 17:00:39 +0000
Message-ID: <m2356h24so.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0071.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::35) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|IA1PR10MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: 6399a9e3-b40b-4568-d5ec-08db1e6453c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6u5ji98d8Y8zIIV/1kb3QWRJJLtpAKRYX8RxapWPVN4nlu1gNYUeySq4AGhOtWVYiiJ+QcI/5SG1NnCnYOBXvjPrqn7VSdEPZr0Hw0rKFoBSqTnb3fnnOhALeYobIwIWcpS8yiaojkwt0wiNTjJ8cO7Ui/XMYRG9dAtYEJ7C3n43MzyYbgyzKcxyoaIwgTNPlAJPb4LFOCJS1tpvYAdaLdTwzNsgS12xM26LhU+B+fBs7wrTwRlN6Emw/3RUIIxwnpvam0cbbzieGUwcEq01Zja3qHTpaYe/gPAdBg3FlucRAkTznB4KK8HaWXTPDAYxSjSVO2XINbKWLmdCWm/FMc/V/8gCqGOEMebfi01X6gZDwNFVri7IDu2nksjqGCnpv/WB8z6XVOxQ2jyHaWzaidmEgZqDMMIapDtOJOMWyKOlMGHdBfgejUaLs2OU3gSI91/LALN+qdPnrbQTcSTGob92Kb0UerKAT/sL7jCM9j7URfW/T101oSBEgCCRmWvFEm9v7Pt0Lq8E+09KaeWEXCSKSzLtc58TVI0pxE1SXnG9SUa5SqTMu/VCqU8eurC3TUv6jYc9hMrpHc69OfjnAvEya/4I7Rj0NAarn1RDXN1CdPNfbzsw/rKqAvQOdgjIziTN3My+XekN0OpATnoCY7RsR/rwaD9/koSWlynC0G8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4926.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199018)(7416002)(5660300002)(8936002)(2906002)(44832011)(54906003)(316002)(36756003)(83380400001)(16799955002)(41300700001)(66946007)(66476007)(8676002)(26005)(6512007)(4326008)(2616005)(921005)(6666004)(186003)(6506007)(6486002)(66556008)(86362001)(966005)(478600001)(66899018)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?oNbtl5h5wKa0yULBXdORNWiclnq/vBifKXDFf/J+6vrCc1KqKl9jXJuvCHEE?=
 =?us-ascii?Q?dwqnB7nW6PnUGrVu31dK1zRtkYoS90Up/w6oT7h+qkdiHuSy/KPInT18whYJ?=
 =?us-ascii?Q?lPtHGIAYtvKPpMq93FB4h+bWkHIkSxDBwam2KZtBBk5OyLpb/MNmSiB1lj5/?=
 =?us-ascii?Q?G3iPZsbw8CynHWCssXnuj1lSg23iuO3HTA1wMZsSs7PDw6MyQ+u6lc5Ovlop?=
 =?us-ascii?Q?H1HRzWVILQffEdSP58ZaK02gw9saDQDb/o6lIf3ULk75b0BXEtJgQ+wPL8tA?=
 =?us-ascii?Q?BESE6gAGth6fIyuSWwnS9kyAf627s7iRZyt8dVtmnJ+BGHzkmDnh1bKZWLSC?=
 =?us-ascii?Q?F1qXjKjR3Jr21HL8rDRdpB7u8r9DNzkSK9aEasT0KWDSW6jEaRmYlrPI+9s4?=
 =?us-ascii?Q?T8YNwVtyx5Q6rjmzj46noC2omz/etZ4eo5O3zCZMKduN4uIteporcWQ62LdE?=
 =?us-ascii?Q?bi3yY/uiho1QOTPftXQmWRGE53pMzpOuGn/jtoJfHSAG8+cPwjuN40RKGU3X?=
 =?us-ascii?Q?W4KIzxGp0ANugvPI/heIOXvc9s387gCaFRFLmjDYMuOv415lEJcGWHvlqJaM?=
 =?us-ascii?Q?1lb/kJsFKQoyQNddsP+jkqa78fIGDfsGia42scTSW1/24Y5eIdQhYgiTWrim?=
 =?us-ascii?Q?oBapysfJ//qYS4Os4NQsQYNsqTMPIpbKKyj60A+2VAow85gVu5PqyO8gdDu7?=
 =?us-ascii?Q?/ASb058w1LqjDzkljoG9q5iQ8oezFRWKHhV6z5vOhOZ7xxAEEjjb/YSeLeb/?=
 =?us-ascii?Q?+zb/VXDVycLtUzkzEA4e7DmxE5wRQ+zibVZY5sR71ChSvQ4UjeRMmcLILh0d?=
 =?us-ascii?Q?n2xNm6Ruv1QOgq3LGqg/RuMJew60paSGMNOZ3Rou/noO8QBI/yGww9SaesLs?=
 =?us-ascii?Q?VOJEZ2rmrc0l/dKKPVPVJkPltdYIWc7pvLhzAPLqDtR6WKSStI2Fq+Opeq9x?=
 =?us-ascii?Q?usCYuIezA+mO4mIrUZyFBqBmnMhWTlCmmJC7EhBos81FXJJkhirR+KsdWRP7?=
 =?us-ascii?Q?q2+tIXEkqHc3P0BKImKoWGnfgnaDsj2NW5a/RTQ0I9Fd45/0WmS8O2juKRKF?=
 =?us-ascii?Q?YkWyZ38+HPSPwbDF0FMzgx71eYbEetahiY8wrv5YFufdsjzhUrtAePCBHie+?=
 =?us-ascii?Q?Js0EFUYj+Ccsdc1t/bjTJYUGrWU+mhvRvTb2WFX9KfcvNBy3E7HJG494jWaY?=
 =?us-ascii?Q?9qTZH1C2+hKhbraUSyBDcEziWA36ttVlaTC9N3DQm4AnePVyIR6k0AP6gaEA?=
 =?us-ascii?Q?BF9OD8mSTDw/aUXs01fjJg3IQm68z0Z0/+D6skLbzrNvGFmmH/ef5VS9hrRc?=
 =?us-ascii?Q?5cBVLlANntac4a6k83k29Cc4URUt5qzXGXSaCfvZqkqRrF38Jz59pVQgi7pE?=
 =?us-ascii?Q?raei3XGHgsVKZsezR52hZYnU78ciLmiK+7W7fR15/K2TXSdxdxOqdR+F6tz2?=
 =?us-ascii?Q?QpraVMm+LimKN2ThBmdSfH7wUFQOfHg6bw8nONZ4rG/KtrO+LFntQOIkdP3N?=
 =?us-ascii?Q?TXjYj4nJNejKH5PlDiQ9e04HdA1z1NB+LPpd9yDQKCRNVbws6TBtrGlTi985?=
 =?us-ascii?Q?A5Zema0sHvUURyCyztGBe4/7jmVwSw4GjbR3Kat9smjAkvh39D+6H6GG5cjG?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1McPkA3M569GXK4bu0OtJfh9xVzEsV2IxAe4KBGTIPG2pWuhEsv4wTPr6QXC2LBivnX64APxkIQrdqHHFCyrGYNj5UILrw6ug99cFWvXpHt1SLAxfCUSUwTDmykOOWGH3BDq25fDokSMeY6WcHEptFuLYs3C36JxDT1x/hznERS6/m1PWKlN0CyFSit02G0Vxt2Y3eQBEgO77bJ7U7M9BN5i/Zn2Hx1SiXx97R0Dbq3x93HcJyqZKaZK9pIy3vilb4epSNLRSL4urSzQflWtrVWHZ9Yf5h2FIDZ25lzfcpiqzArNb25QVU6G0hKjeiT3jKNoirjI5CyUmOMjhB892MFqE215q7L+bMD5k82M4Ja2AVCsZ57LxvYqR1eI3Kc+lFV66zE/LwnIH22DQw0h0Gz17G8Bj0upWC32cQCXyROoka7JBsYynps3R0oxYOKqNY3uFpDyrRtvlEaF+/GryQZknQL6uisfiBpIrmkOWO2phXwgab9yMOhd5Wa7xOD/gnRjIYpYSm/85GnHDELUQI9aJd+OYiRumlQ7XhgKP2d/I7xAPmXcUHqUwTLokUAWj3KE18+DOpJNntKpdoVa5PEGC7HjzyXR71P3tqVMC/0sZul5Ti0TNejJR0ldSIvywnRuCWbDquKjDpuoyb7fKraBpghSAj4DsRwqLH7zzpV2odaoJick+CPjK98l95GwfmgA3gMyubnsRlqCa0qsMSzZER7AfyAeZ45BJUYukngcLnMtA425Y8V3Bk+wAL5bxX3csXBYwmSO5/fxK23unNxa5YQIgRx3InSxYsapZmYLHPu5zPYwCWRDDFxIy2buclWQNK1G2YKATFBLFeZpgzaWy9rqll9m5NOk7MpW9XqX91WvlUFFUuDE5xDQOKmarcM3hsrD/qL1h53dxYTIsQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6399a9e3-b40b-4568-d5ec-08db1e6453c6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 17:00:45.6971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kTWGAhIpPKIVwrjS/1L+nSq8MfQ6AAAkkpomGcbGNPu2rldkr84fWXESumB5sHX0Z2yPKb7KLXlCx+B5wVncZGPOhYFZPDnK6aJ0r2WOZfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7515
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_10,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303060150
X-Proofpoint-GUID: IphTse1QzSyllZLqoDFhLiC07Ls0R61m
X-Proofpoint-ORIG-GUID: IphTse1QzSyllZLqoDFhLiC07Ls0R61m
Subject: [virtio-dev] Re: [virtio] [PATCH v10 02/10] admin: introduce device group and
 related concepts

"Michael S. Tsirkin" <mst@redhat.com> writes:

> Each device group has a type. For now, define one initial group:

"one initial type"

> SR-IOV type - PCI SR-IOV virtual functions (VFs) of a given
> PCI SR-IOV physical function (PF). This group may contain zero or more
> virtio devices according to NumVFs configured.
>
> Each device within a group has a unique identifier. This identifier
> is the group member identifier.
>
> Note: one can argue both ways whether the new device group handling
> functionality (this and following patches) is closer
> to a new device type or a new transport type.
>
> However, I expect that we will add more features in the near future. To
> facilitate this as much as possible of the text is located in the new
> admin chapter.
>
> I did my best to minimize transport-specific text.
>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  admin.tex   | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  content.tex |  2 ++
>  2 files changed, 51 insertions(+)
>  create mode 100644 admin.tex
>
> diff --git a/admin.tex b/admin.tex
> new file mode 100644
> index 0000000..3dc47be
> --- /dev/null
> +++ b/admin.tex
> @@ -0,0 +1,49 @@
> +\section{Device groups}\label{sec:Basic Facilities of a Virtio Device / Device groups}
> +
> +It is occasionally useful to have a device control a group of
> +other devices. Terminology used in such cases:
> +
> +\begin{description}
> +\item[Device group]
> +        or just group, includes zero or more devices.
> +\item[Owner device]
> +        or owner, the device controlling the group.
> +\item[Member device]
> +        a device within a group. The owner device itself is not
> +	a member of the group.
> +\item[Member identifier]
> +        each member has this identifier, unique within the group
> +	and used to address it through the owner device.
> +\item[Group type identifier]
> +	specifies what kind of member devices there are in a
> +	group, how is the member identifier is interpreted

s/how is/how/

> +	and what kind of control the owner has.
> +	A given owner can control a single group of a given type,
> +	thus the type and the owner together identify the group.

If a given owner can control groups of different types (which is implied
by the above?), perhaps worth being explicit that this is the case, or
not if that is not the intention.

> +	\footnote{Even though some group types only support
> +			specific transports, group type identifiers
> +			are global rather than transport-specific -
> +			we don't expect a flood of new group types.}
> +\end{description}
> +
> +The following group types, and their identifiers, are currently specified):

Spurious close parenthesis.

> +\begin{description}
> +\item[SR-IOV group type (0x1)]
> +This device group has a PCI Single Root I/O Virtualization
> +(SR-IOV) physical function (PF) device as the owner and includes
> +all its SR-IOV virtual functions (VFs) as members (see
> +\hyperref[intro:PCIe]{[PCIe]}).
> +
> +The PF device itself is not a member of the group.
> +
> +The group type identifier for this group is 0x1.
> +
> +A member identifier for this group can have a value from 0x1 to 0xFFFF
> +and equals the SR-IOV VF number of the member device (see
> +\hyperref[intro:PCIe]{[PCIe]}).
> +
> +Both owner and member devices for this group type use the Virtio
> +PCI transport (see \ref{sec:Virtio Transport Options / Virtio Over PCI Bus}).
> +\end{description}
> +
> +
> diff --git a/content.tex b/content.tex
> index 0c2d917..ffe45c4 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -491,6 +491,8 @@ \section{Exporting Objects}\label{sec:Basic Facilities of a Virtio Device / Expo
>  types. It is RECOMMENDED that devices generate version 4
>  UUIDs as specified by \hyperref[intro:rfc4122]{[RFC4122]}.
>  
> +\input{admin.tex}
> +
>  \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
>  
>  We start with an overview of device initialization, then expand on the
> -- 
> MST
>
>
> ---------------------------------------------------------------------
> To unsubscribe from this mail list, you must leave the OASIS TC that 
> generates this mail.  Follow this link to all your TCs in OASIS at:
> https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

