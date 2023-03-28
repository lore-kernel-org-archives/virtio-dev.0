Return-Path: <virtio-dev-return-11810-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B109C6FD18
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 13:57:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B15198443C
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 13:57:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A7425986429
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 13:57:13 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9AC1E9863C2; Tue, 28 Mar 2023 13:57:13 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8903598638E;
	Tue, 28 Mar 2023 13:57:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcVTKIxwuUJ1Tw4eL9Vgz8ZVkbqg9pl9z3U5jkVLSKjZTsz8onotdepCbMtDMvZ96DEu6bD6+ZExrr6HrW2M8tYwYbtRItxGfsD4EQt7KzbsFGDr+IkSuz37pvLCbXVZkuylqG9hVOrbxw9c/0VDsLpQ8qrdPXZvs5+rKiatRPbZbdaelPN3u2CttAFijz2QU3ydKrHs1X8h+j/H1B1gTTWAQzKfjmNu0XNsoMOZRM+w9dZluZ5nGF5SwW72MTmIBRpLulh47wVazYGD2iGFhXc6l2GDHzlJkUJIya/p5Q6XDCGyeqrFYJ/Ovuf+YDzkNItjlDvMUWvkUF+37koKpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DKqRMOKTOPzdtEmwF0+NKulwHG39ydwYStosSk9rUM=;
 b=S7gOTZwH4M3UZNeTta6ykRsNi2Vda9e81GfzesUyfoRJdi12U8gHqFA6dcEtfyftaFtHx9VGXQsfsLQZ7P0LVTa26aopyjGHSW+qp9cODqMyegN2oGZNKooVKZdsEth+r5hn0ToKS6V1cgYceV8/A5CV14DmpSdmT1682y3Eh9VJ9rqW+0RVxo62CZ+pci2FhGxKZHxhzcF7yEbvNVTN6HwZHBhqlHCHPwy70hCDoV+TFyoWUmWt7R/HNMWF0FO6uVm+4lJF/GepUFITErah9MgV7kEmWGZ9h9wWET5BZ7s97fThywy7DL8hvfwud6bz+mEplJnw9DEpM2CG2zoFHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
From: David Edmondson <david.edmondson@oracle.com>
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com,
        virtio-dev@lists.oasis-open.org, pasic@linux.ibm.com,
        cohuck@redhat.com
Cc: sgarzare@redhat.com, virtio-comment@lists.oasis-open.org,
        shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230327235936.414196-2-parav@nvidia.com>
References: <20230327235936.414196-1-parav@nvidia.com>
 <20230327235936.414196-2-parav@nvidia.com>
Date: Tue, 28 Mar 2023 14:56:47 +0100
Message-ID: <m2bkkdc734.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0114.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::30) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|DS0PR10MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: 9304c32c-d738-4c06-4d46-08db2f9448da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qd4R40wd6/giTmatoYkfRu8rJ65LH3BvY5T82M5vncg1gVHsoszF+lpZzD3Ttt0sJbPrR+5NtIZ6zY2CaSzQfxnO0vQeLf5rJ1OXAdwUSMsOLPD4A56fPLTa1nyOhjRAJL9exT3RxG+jeUyUL3gtSTyeis+ONdIPdysl4eXA2ATDGsveToEwOqs9oPuK9deh5Gon1R71PYl8S468/0t3oAAmScype6Y6wgC8W0KXjzkouaa5ywZFb+aPGGwyHr64+s1sBPIobaSNKdkUi2357VPG6kW/6FvVj4SutEmqVQpfPU8jHsJA5f+EBi/xhD0aOJWL/tbm4kMtWKxKPa514iW7E9gjhrqQm2xGqk+zCLPSeF2gxJ1PmuVGpX3Tec2FmRBr0WignLZU6joTGGzlB85KWbYgRxiNbhxytnOJ9+QXS3vZecNnDjDdYJR9sWHb/7cKQE2xiIwp05kOMQXuUjphld1096m9Lj6NKWDGmoHHwcBbwxhc0x8lP3YHkou+s270QnTRJtyRHOh/WN8UerhVk/icbHWBg1Xw75bOp4I=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4926.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(396003)(366004)(136003)(376002)(451199021)(66899021)(8936002)(83380400001)(2616005)(41300700001)(44832011)(36756003)(86362001)(38100700002)(5660300002)(6486002)(966005)(478600001)(66946007)(66556008)(2906002)(8676002)(66476007)(6512007)(4326008)(6506007)(6666004)(186003)(316002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1MfefIaJWxo/my8taqt4iXGlg/C+5SQFupMPqpwq5MEjo06ZSj/JdaAy7pMN?=
 =?us-ascii?Q?z/KlfIVCfacsbYC3wRs9oMCSQf+inR2pGtPdWErOhHvoDPAN/7524x2wrZys?=
 =?us-ascii?Q?W/dfSQdnJsjUArwQvwXc0i/X+ycOhKc8Umbrv5vpit24qbiwSCA+j3vAh0V2?=
 =?us-ascii?Q?7vuz2NrqDwUrGD3tfsN4QTRC2DbQw/vRVUumKCFAELaGaKwbv4TNAzhUjoIv?=
 =?us-ascii?Q?ppxIA6gVjnMSZSEBj/o7uuJmBv1UNCsr9h6JuCd/ayGGYR636qhKsLOMiVAc?=
 =?us-ascii?Q?m25LwlBql1ljjMi22ZJMTrEkBjIN+8uf34ZTqQB37zv3uMtfelHLShvQ/UOd?=
 =?us-ascii?Q?PKX42jAHRAmv0HRLogTDtrbfVBgae5Jj/2f6dZ8tutFpkoLJRsuXClLEiUt1?=
 =?us-ascii?Q?d9yZu3yB9xa4E/gADOB5Fb2D4/ORsHV579lzWn4FN8KhyVLyBUrayOYa0xYr?=
 =?us-ascii?Q?oSUJHQ3ZHGpOkzCH1M8Cp3jmi0XdZdk0vPKdB+vFl3CPyYSBflJMHX0fWtCe?=
 =?us-ascii?Q?JHatma3AJ8zq8uhUoR11qXYMfFYXwzvAw5nsWj4lkqO4Q4jdQI67SXO3/YpD?=
 =?us-ascii?Q?0fn+nG27a+fxTt+ot80EDICDebOTvSFEa0+Q8k6zpqVbzbETTJ0lM7wkPnV3?=
 =?us-ascii?Q?ciM81j5zIYGv3xWZK+FNaov1BKaOYVZopfuswBV8Dm9eAUgc/TA0Ya0HfI6W?=
 =?us-ascii?Q?AG5u7wsAZGSbmrW4PlO8Rj1bH22izmYeC1M39g17KMVkgHh4sCHRViZauO1G?=
 =?us-ascii?Q?0L0RXmpc71ZJXaDRXqivEbirMSGuz9q0B4LYphBySFACBe2CPjdUqXP8zm3I?=
 =?us-ascii?Q?nbRqdQUmO5aHe0yw9V+m3MbjkIS+xjfAFp4fwb55b1mBNymt9sHxqF+ZkwOS?=
 =?us-ascii?Q?848urhsNMRqsxITaWP8ta1Mc0mafe8frO/pqEGrtznfXlP0uxtFjYBy9Bpqe?=
 =?us-ascii?Q?tYUpAkzZAB4a4FkftsNNI+ar46m+x0JPN2dgxLLsqzF2dyApot/oWP9irGW1?=
 =?us-ascii?Q?mFtDATcEdhtoKHU2S4pnJKHA6NjGRBLxRDaVnqOL3L3cYVh+pVQL+gremMv7?=
 =?us-ascii?Q?DuPONGQwUMj37eKZmEIgeHoLe5/Vp928FLooj4d9a7iqCIUbbmEbautwwoyu?=
 =?us-ascii?Q?cXiBpLTS7gw/pMjLu5NeQSd2lW+a1yMGf0/7RIAfdmUokzi42MOZ0/uqJK/y?=
 =?us-ascii?Q?C4AVDvc9heCLkG4EutKtL3HEq34cuaxe7nSldmq5TBckQWUocyDyagjzQewA?=
 =?us-ascii?Q?MxL1xjII6wf9wFmB7HDW0br7yv2J4tos2c6Q6F6iBGwbAeWcZnYmNZPa/N6O?=
 =?us-ascii?Q?8y4NNpqLFkz4l4iv+lLjmdpZzAS4sF1Q5o4KV0noxH1kN31HuHND5eFcxfBI?=
 =?us-ascii?Q?AB8o+nX8S2Xl5+6wGD7faNehOdgqI8RSFfjQ+Z9TmCCUj8N4rEsMEjxIIC4q?=
 =?us-ascii?Q?EPiN3JTMfHRaxcx9wl8+GHBCKPW1cF6NLXL8vMG2g6alvCSZNxBEouarTWmS?=
 =?us-ascii?Q?vb+oOsNhgoAsnStUrs80uEBjFNGJgLIO3aTR8hFdVlcZp86luJb6pzU9bdr3?=
 =?us-ascii?Q?xctYXpcsaAj0Ajnc4ySfczsbO9v6dGwqFgow2H5P2eItoy/3vX0zjWqDaibO?=
 =?us-ascii?Q?Kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XlJaJNSSjqyXMocJsrgkVqmXDxBrFN26LiBNQtm0Rt4Uyg0WhpFtFaiUmsPTqBSBhdwMfKEsmh54FzRh9mYdcAmV5AtYI+gEW+YbhfvqX2lgsJZEOt9EiQPwaG27uwfDenJRmO74JrRFsVtIX3vD4KqBXWU8Cr8w47JX8fTpjkmJvxhl7+2BnpRlFI1LKXgeSWkji1raWAfahwg0h4LHTfHW6JEsMmCljSRlvBv5ucgpOTvqEmw1Rc4/GDzkuIKsyFbfXZk51Sd0h2ZCxaKBykajmeP4sRU7woMkT9+2jkpCc+SBbXxndqaC7UYEARi+xL+fMl4t+1yb5mutBwnDQ6uMVLRe76mwGvkoiyK4xuVdBypo8Y2hFWiMOyw12CE7wlfCzahnW5xzzQeSVZv3odobgU2+opB5YgaJdSaLssBGih43w3B7ASVfNEslD2FaCRYo+u0EV55ZwUtCvtLPbuUtHAz28Asb3oRoCyoV674EW/SnI5rVs78odQFR7jzlXgtG1XUCWherLXJGDEo+lgvxN0Lwwhe8Z/8sgf+vgQnhzQVM2wnRuzbbUMDCrdM59Jp9Y0JZRD3pj/ldWXTxWL+AJoSIthczIQABIiYqGgqniBA0CqLQ0P0LI7m0cqvId8Hj4iWysfhylFW2ecUN1Uj9mHuZ5hQe4iVML8t+LFlGQWJnXsG1yq3nA1CV5cgK4Owhyddntlt3AYA4j/C+zHtDFCmpUE1Nxb4Xjv8Quqyu6KmxKB5TOAa+Kvz+IbXBmBaV1+dEEFJzGQAdgZm0yTbDWVLk2bAHAvggg7dELjNSzCY9DBkgBpzxX69cYnl2zjJuThAart9FM6sGpRrjypZVFYT1aeUjrjsEMOu3m3w4+DdT5cI7b1lUmdsX4NzP
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9304c32c-d738-4c06-4d46-08db2f9448da
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 13:56:52.9309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: am9RgoLqTLLXT4gpam0Dlx0svEx05I3vAIVyABvStKNnnYT5OMYTU76K1S3uZyMZxuMJY6hfQkycrxKztVAy1ebtx3INXgPTM8HeRW0WcRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7222
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303280110
X-Proofpoint-ORIG-GUID: wlnQ0b17BzwmBzmUlM5obcMHmU-hjdHA
X-Proofpoint-GUID: wlnQ0b17BzwmBzmUlM5obcMHmU-hjdHA
Subject: Re: [virtio-dev] [PATCH v8 1/8] content: Add vq number text

Parav Pandit <parav@nvidia.com> writes:

> Introduce vq number and its range so that subsequent patches can refer
> to it.
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
> changelog:
> v5->v6:
> - moved description close to introduction, it was in middle of
>   queue data transfer description
> v2->v3:
> - new patch
> ---
>  content.tex | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/content.tex b/content.tex
> index cff548a..5171c12 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -298,6 +298,9 @@ \section{Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Virtqueues}
>  virtqueues\footnote{For example, the simplest network device has one virtqueue for
>  transmit and one for receive.}.
>  
> +Each virtqueue is identified by a vq number or also referred
> +to as a virtqueue number; vq number range is from 0 to 65535.
> +

It would be nice to use the unabbreviated version first, and we could
also include "vqn", as it's in use during discussions:

  Each virtqueue is identified by a virtqueue number, also referred to
  as a vq number or vqn. The range of virtqueue numbers is 0 to 65535
  inclusive.

>  Driver makes requests available to device by adding
>  an available buffer to the queue, i.e., adding a buffer
>  describing the request to a virtqueue, and optionally triggering
> -- 
> 2.26.2
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
-- 
The sound of a barking dog on a loop, a plane rises in the crystal blue.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

