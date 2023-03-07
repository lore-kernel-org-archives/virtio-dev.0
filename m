Return-Path: <virtio-dev-return-11480-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA8CC678D5
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 15:08:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0F1F342A6F
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 15:08:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F1BFB9866D4
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 15:08:08 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E4B309866C6; Tue,  7 Mar 2023 15:08:08 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D0EFA9866C3;
	Tue,  7 Mar 2023 15:08:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ta4nqrZQI/4kyvQsAtWk3oP/g07ZkTwBLO/8VFLtkLTI7a+stsANiwEXSI1YQx/aXbAnQ3xxaq22aegAQ5iCTApRqT4Tbsyjk4mxURf7qxLCltwP+pQV02/2/6HZ4xIj2Ey8T+GeeqqoKubloqg2kkOgRRhA6o2Bzzj9nEjz1UWHHQdEaf3RMzlcguFBhBYYz5Gx5nuQUgjCDtrdVrugikygdZR8+GVvlyTbmorF+TsoTdMJnPv+Radr/wi4HA3WT0kTWweHJv7djIPogp4oydSWf2fOPmznyxnht7bDs1YJBxfzJ3gcMm0s45vFLpTd+JSa0kmilsYc1io4aPEDuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWaF3CJVCnD9Q221ISippEWdFg53YzZo2VoHNYWwxA4=;
 b=bxDaT0zKktGO0B6ZUbeBEkVNMBk7r+EE93emYwbw4jw22WKqdnOO2U/33IR4LM/3ktzRE2OyrP0bqhKAqvBJWTyw8MTmFT1E56rQGr1Yavkr+YStpFO1WnKgooBTqO+BhGn3NHsiGyPr57Hjwqqz9Awl51SCjNitCq2yAoDmprVmCmJd3vstXixgCr8MD1fA0DLC2OMNyH9qZAANFzIqc/Y5bFAuvseyWYPCL0isNMYaavl0v/gz+lJ+hRIVgLsYHpMVTxObhYJoXzJaQxIzqGBrva+vtDPAr00mVYdtt1O/Jbppl2EAHXfz/LPOtCI3X1YAQILn0s3MudMuKUAf1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Date: Tue, 7 Mar 2023 16:07:54 +0100
From: Jiri Pirko <jiri@nvidia.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org, jasowang@redhat.com,
	cohuck@redhat.com, sgarzare@redhat.com, nrupal.jani@intel.com,
	Piotr.Uminski@intel.com, hang.yuan@intel.com,
	virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <ZAdTSiVJGSrRIqZ3@nanopsycho>
References: <20230303132840.GC2866370@fedora>
 <20230303083213-mutt-send-email-mst@kernel.org>
 <20230303202133.GA2901137@fedora>
 <20230305043419-mutt-send-email-mst@kernel.org>
 <20230306000302.GA244754@fedora>
 <20230305191351-mutt-send-email-mst@kernel.org>
 <20230306110340.GA35392@fedora>
 <20230306133525-mutt-send-email-mst@kernel.org>
 <ZAbvxj+7lgaI1HkI@nanopsycho>
 <20230307143911.GC124259@fedora>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307143911.GC124259@fedora>
X-ClientProxiedBy: FR2P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::9) To MN0PR12MB5979.namprd12.prod.outlook.com
 (2603:10b6:208:37e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5979:EE_|MN0PR12MB6317:EE_
X-MS-Office365-Filtering-Correlation-Id: 9beb2cbc-c2b8-4e74-a3eb-08db1f1dbce3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QhasY8VkE9kI0Pe8rayGpY/4cnY9K/2mALsBphxGgvxGjMC0vJtmEfKDqwGofMNOUzHvARhIhhVlJpV9GVp0t55RLoGp1o4aST5D51hRWDj/2NMV59bhu5LMpuEZIUmb0z31X2wTx2f5sl31KDRiF13JvAhyw7v3QfQc2dWLAKpPW8Y9wIfkUml+IPD4Ie/M5bf/u5I4mMtOamKgT9ttnyoHoL9RZhGv5WoR5yFYrfsjU0GYoe24eEHnWEetrDbI5SwXN9vpZaTPv18Gp5tiZjCbR/4fLrZ3dX9LrFFrlvvSRYbCuVx8lsuQ+GwdQyriJYyNfIgojnqM2A6G1b2hf6IDu4kim/1HcAZ9A4GwAe+S5CqMNgghISqxC/7Ly66Xzd9+ZeUk68UcEZCfuR63D9gnVPs7f5C2qy6vwk8lT0NvKmlcXOOhZ72xwesUCSHw4JDRwEn8O/9/BRI9N0lUatzvugmUNdsZvsUe53BAoF9H3hXnH7xlifPbcOs8ptHI4Mht9tE3TXcpd9oH9YfkAh3QoW3qP0xprT4qzwpk3Z0VPeR52UySzsF+CVMibkMakWZSy4KKJDUE0J3E0s/54gpMo7cCJw9wWELfP9awBc7HkClQI7+1XAYrOQ7Oeg8f+qZnq3EUthcfH4YG5178Lg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5979.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199018)(186003)(33716001)(9686003)(86362001)(6512007)(26005)(6506007)(83380400001)(38100700002)(41300700001)(66946007)(66556008)(8676002)(66476007)(4326008)(6916009)(2906002)(5660300002)(7416002)(8936002)(6486002)(107886003)(6666004)(478600001)(316002)(54906003)(66899018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/A92sUgK2Qnagg9ARrIW8Rv0lawfrgsHkRjgv3HofgoczD9ekLeaM5drnxx6?=
 =?us-ascii?Q?ty9zcoBf6FWQ5bL09QcdYpErH+26mf0eKAzXFog4JWJhFDZhmMDnRb/hGKHa?=
 =?us-ascii?Q?TptjwtQm40TR1hnsH3AiY2m0YmSP+hAI3DkG8oX/tCftMPNi3/dHsiiIREEt?=
 =?us-ascii?Q?Vc0GptAx9qTA+iuW5SCKyS5+K7WVoECKSdiNSn6O/aTQmpTUfbku55wQzZKi?=
 =?us-ascii?Q?w+SvZY25Mk1kJRYtoQWFQaTUShJu94J8+nzU47K6+j82+rIOBwr/FpJVyyOG?=
 =?us-ascii?Q?J/WUIiY0GytQAycy9yzMu4iitaEQhwG5fShsZAYlhl/nUiGJvAIZYFxBnf16?=
 =?us-ascii?Q?vt3SonmhcD+18Qc7xED0FVMAawg8RK3gTmHK1PvnjwbDzsDl2ftiCpksX1Mv?=
 =?us-ascii?Q?8SgilcErnXnvcVXjBTvQThHayyTki1+c9LrGf+FnekQMYnB7ZtedmkA83OU1?=
 =?us-ascii?Q?J+kLUVROkttqqNpSlj1QoBGc/FkUtyLXka4Z0UiRcFxjsL63fI54cYyJMTh7?=
 =?us-ascii?Q?atyzl2mIZGgsdyxO853Z1cKgAiuIfJO1+q+aGrLy8K63FLfOEF045LPnD4Zp?=
 =?us-ascii?Q?ofrvIM4NZfTSq5bwv9XQdn5DcHtBdGbqD0OT7UUlBHJiaIi+xXvrVsybNZx9?=
 =?us-ascii?Q?8+jojgCdNcVQ8wakY4PS4F5riy3/2f6+Y54jRZbYqEQe5wL704NZAKgwgeAb?=
 =?us-ascii?Q?BK8JU2tizQ1Zovo2omOynKQBam9YQbOH/cgpPTAaz7GtmanjxI/n7wRG/Tro?=
 =?us-ascii?Q?+ACpT50daUzY/8CTTtzACdldPJ7uAdPrb7U9mau1ey/LTv6OnWIB+DBjvOI0?=
 =?us-ascii?Q?p0cBPDx/4dNL5JerfHBnccXArMvBROfdrTB1dI5MeTAm/dEYMJdtuEMdAncw?=
 =?us-ascii?Q?QB43g0J/2LUy+RPahwNgt25Bd7PA8xmi8cWgRHq0xZMuxVLn3UjnbxbCv6IN?=
 =?us-ascii?Q?m/IMgywNimc49kpvbEt9hv+RLYGJIr470xVX7ybbwomiuP10rmyRjvLYExF3?=
 =?us-ascii?Q?WRRty6mh0w1gqCWyL563RtSzYZ7+2/FpbfL/bqnlMKNzcTRkxynA+TX93bDT?=
 =?us-ascii?Q?qOufwZcEjB6xwNoJdxhHmIKRbHKa+qmsRvhrzY0KKkcCA4seoFR7TxtLCRIu?=
 =?us-ascii?Q?3xoVD/jeOdlmB6IoDw3dlu4m2EUC4SqevoyMLjFLNiJKuJCGQW9tiCiWcVdD?=
 =?us-ascii?Q?t8bItawW17bGfxFDy39bitxj+81qiO8wDzVFGaxybj2fbqkgRFmQCPI/UlLG?=
 =?us-ascii?Q?TEX3bnAakcEUl3BMA9gNEiewi7ed737lBCKLQktUuPtP2Urp8lZ2bbAl9Clm?=
 =?us-ascii?Q?uGuQb3sPiTdBX8jMjKvEo+dKXLqVh1FapNcczlWk4hGZRtiXQofjs7xTHHgG?=
 =?us-ascii?Q?heWdYup1IBCYmbqnbVUTHe3exSUpCmoR67Yg6DCxpn4DDXizPcG6gnyj7WCT?=
 =?us-ascii?Q?uM2h9UzbhKjCXwrWQ4OOmKoN6p30Ty6O7TKTbOKabfCp9SEm4YhggASta74Q?=
 =?us-ascii?Q?c7oZmGxDnmT/pa+9uaSSFZzNde2pyO4mRnkS6k2M0c8/kDlNfHF8Dlrx0v23?=
 =?us-ascii?Q?0FyV9fbDykbhFVp98PpadNXJzNzHt4s/RFttX292?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9beb2cbc-c2b8-4e74-a3eb-08db1f1dbce3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5979.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 15:07:58.8323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1UgWq26uikLFrJkhyDozWo7DGROdhdGsiDV7qOU3dtEI9P5lmyy1/M9T1lgjQbhw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6317
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio] Re: [PATCH v10 04/10] admin:
 introduce virtio admin virtqueues

Tue, Mar 07, 2023 at 03:39:11PM CET, stefanha@redhat.com wrote:
>On Tue, Mar 07, 2023 at 09:03:18AM +0100, Jiri Pirko wrote:
>> Mon, Mar 06, 2023 at 07:37:31PM CET, mst@redhat.com wrote:
>> >On Mon, Mar 06, 2023 at 06:03:40AM -0500, Stefan Hajnoczi wrote:
>> >> On Sun, Mar 05, 2023 at 07:18:24PM -0500, Michael S. Tsirkin wrote:
>> >> > On Sun, Mar 05, 2023 at 07:03:02PM -0500, Stefan Hajnoczi wrote:
>> >> > > On Sun, Mar 05, 2023 at 04:38:59AM -0500, Michael S. Tsirkin wrote:
>> >> > > > On Fri, Mar 03, 2023 at 03:21:33PM -0500, Stefan Hajnoczi wrote:
>> >> > > > > What happens if a command takes 1 second to complete, is the device
>> >> > > > > allowed to process the next command from the virtqueue during this time,
>> >> > > > > possibly completing it before the first command?
>> >> > > > > 
>> >> > > > > This requires additional clarification in the spec because "they are
>> >> > > > > processed by the device in the order in which they are queued" does not
>> >> > > > > explain whether commands block the virtqueue (in order completion) or
>> >> > > > > not (out of order completion).
>> >> > > > 
>> >> > > > Oh I begin to see. Hmm how does e.g. virtio scsi handle this?
>> >> > > 
>> >> > > virtio-scsi, virtio-blk, and NVMe requests may complete out of order.
>> >> > > Several may be processed by the device at the same time.
>> >> > 
>> >> > Let's say I submit a write followed by read - is read
>> >> > guaranteed to return an up to date info?
>> >> 
>> >> In general, no. The driver must wait for the write completion before
>> >> submitting the read if it wants consistency.
>> >> 
>> >> Stefan
>> >
>> >I see.  I think it's a good design to follow then.
>> 
>> Hmm, is it suitable to have this approach for configuration interface?
>> Storage device is a different beast, having parallel reads and writes
>> makes complete sense for performance.
>> 
>> ->read a req
>> ->read b req
>> ->read c req
>> <-read a rep
>> <-read b rep
>> <-read c rep
>> 
>> There is no dependency, even between writes.
>> 
>> But in case of configuration, does not make any sense to me.
>> Why is it needed? To pass the burden of consistency of
>> configuration to driver sounds odd at least.
>> 
>> I sense there is no concete idea about what the "admin virtqueue" should
>> serve for exactly.
>
>It's useful for long-running commands because they prevent other
>commands from executing.
>
>An example I've given is that deleting a group member might require
>waiting for the group member's I/O activity to finish. If that I/O
>activity cannot be cancelled instantaneously, then it could take an
>unbounded amount of time to delete the group member. The device would be
>unable to process futher admin commands.

I see. Then I believe that the device should handle the dependencies.
Example 1:
-> REQ cmd to create group member A
-> REQ cmd to create group member B
<- REP cmd to create group member A
<- REP cmd to create group member B

The device according to internal implementation can either serialize the
2 group member creations or do it in parallel, if it supports it.

Example 2:
-> REQ cmd to create group member A
-> REQ cmd config group member A
<- REP cmd to create group member A
<- REP cmd config group member A

Here the serialization is necessary and the device is the one to take
care of it.

Makes sense?

>
>Group member creation might have similar issues if it involves acquiring
>remote resources (e.g. connecting to a Ceph cluster or allocating ports
>on a distributed network switch). It can be impossible to defer resource

Sidetrack: this is really fuzzy to me, how the new member is going to be
plugged into backend (network). Over the time, we learned that the
creation of device from the other side (switch side) makes more sense.
That is why I asked for motivation to introduce this infra.


>acquisition/initialization because because VIRTIO devices must be
>available as soon as the driver can see them (i.e. how do populate
>Configuration Space fields if you don't have the details of the resource
>yet?).
>
>So I have raised two questions:
>
>1. What are the admin queue command completion semantics: in-order or
>   out-of-order command completion?

I would add "dependencies/serialization" here.


>
>2. Will there be long-running commands and how will we deal with them
>   when they hang?

Yeah, sounds legit to define it in spec.

>
>Stefan



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

