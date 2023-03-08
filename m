Return-Path: <virtio-dev-return-11519-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D5BFC678D5
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 12:57:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 71E782B353
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 12:57:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 63F359866F2
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 12:57:52 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 533B79866ED; Wed,  8 Mar 2023 12:57:52 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3ED3E9866EE;
	Wed,  8 Mar 2023 12:57:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=amWZxehc7SV6fj3WjL1xIHArSK9baw6Ifrv2gLK4BiBD2/XYdHhCGcSpynnjeNAC6dREf7BP+qRl6H5roGRsG/MBYJ28ogXRlbsQeSE4LYLDYs2I9TFFH3C8iV2FezILvjQzkXtuo0vik7ecNfekRgfM4s2alquzV2w9EoJosPvCsDFJxIPiblYDvcr51i+2FMfUGY314sMV38fYFJx03iGhBpF4+jhQTT4j/kw2PGpRm+ga25Xyo4PMTfvyvY7UaMmz1SVOShdAkUqP5gmsW2hWhf4bEGeyTXX10FJawapX5HIo8o4fCJQj7xmpSmluyQynYGMnTZUju19e0vgang==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5905ajhauRAtXzn2dOcfLVAGxtCT0xpG6Uw1pSp4G8=;
 b=mFJMsoZlhOUw/pLuqOf+5NVIMRY63jbkSEAuIXMtLOzVhAKy3dClQpsoigSnh9QCQoH7rpUL+QiKP37ukQFLyMniHX29FVS2xNXH4Tnh1Neu8ACh+yeQum3ZQqCO8T+1eClEwp+XrUjedwJ0RqTc/U/pmtKjYIcWV/a74ugHXiHMp+wlqqqKxA/gWZsq2TsIMLt34vQYd9lwv4nz9M9+Ul/O5+zKd0C8jSJ0aTeQQ+o8VqzWOKo49+t19YT/MuvB9Y7C47gxQ+uXdeMgnxQfpm+sAJrbJ4irKF3XsSXWslru7cR26aYB7exByA/tpnFGthleaUkHQR3dBOjjYDTjIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Date: Wed, 8 Mar 2023 13:57:43 +0100
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
Message-ID: <ZAiGR/3nGMKWaBtE@nanopsycho>
References: <20230306000302.GA244754@fedora>
 <20230305191351-mutt-send-email-mst@kernel.org>
 <20230306110340.GA35392@fedora>
 <20230306133525-mutt-send-email-mst@kernel.org>
 <ZAbvxj+7lgaI1HkI@nanopsycho>
 <20230307143911.GC124259@fedora>
 <ZAdTSiVJGSrRIqZ3@nanopsycho>
 <20230307190347.GA153228@fedora>
 <ZAhgv21Nnex6vbDf@nanopsycho>
 <20230308124418.GB299426@fedora>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308124418.GB299426@fedora>
X-ClientProxiedBy: FR3P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::11) To MN0PR12MB5979.namprd12.prod.outlook.com
 (2603:10b6:208:37e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5979:EE_|DM6PR12MB4188:EE_
X-MS-Office365-Filtering-Correlation-Id: 81ea6a0d-d592-47b2-534b-08db1fd4b7e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+0143RO7oyUpammzyNK0YnI6T8qPjm3rCoVBGxnr5J6Ck9YiccYj2IFOAgAIm5io5kAiFr/PmZD2id5mk+xvDRkE0DMemvuS7y+2aDKU6mmKAkq33AE5w+uSIn3vkxzUrtl+w3tW5fozrHR/Grpnf/Xu6DQ9AqV7k9WBFYHfJ5mj7VK9taXrhOrzA2CwFm6Fs3awWtqzTiSoYA8PMcFNHVtT61gqHyKbJANQvVKGafstNeonijAL6f0tn2OS1u/ZRmSJfbdCwtXjYG0HXKHcQ7y+Jm/oyNMcUx4I5UwQ2E0bcedmDhV8yEDFl9XDTe9WRnjHCkCj6A8+5Js0q9Vqr2bFafwsR/Zeb5KpYpyqMyVmTQrJuTohh50OLYXu4VgmxkAOlh9w6xDKbshfs+qR8qUCBS4AaKqeqOeol3QUUoVQmWlsuEMqDz9nsYIsM4/dJSGiWhVpnskpI97/T7Itu+H+6WetzScZUejAX8s2Ww7sKRzsDrta00eDCs4iDeYBJYGwcobDgR1dh3fkHfKPv/nJVLTV9DeSAeKKXKkXU2YroCYFehT6OfJ0H0LmkUHMk+L20rsaW3iyNCwgJFAu8+PrXoentgr8kIAS3vRyNg0V6j0GT30Q++yHgcSpOMa/y7FmqoQdJBCtsyb6HxDxCQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5979.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(366004)(136003)(346002)(39860400002)(396003)(376002)(451199018)(83380400001)(6666004)(6506007)(6512007)(9686003)(26005)(186003)(6486002)(66476007)(66556008)(66946007)(8936002)(86362001)(8676002)(2906002)(4326008)(6916009)(41300700001)(7416002)(5660300002)(38100700002)(316002)(107886003)(478600001)(54906003)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NaO3mESibXnI4mUgU2K5hpGuQKWKqc3ArBgtWSb2bViUaWXTRGHK4va+z+fj?=
 =?us-ascii?Q?/9euUQTd5nWy1Q/BJMIPkkdGPRVU/e8w79qso1jepW6C3NEt5LkZyGi/k/Vt?=
 =?us-ascii?Q?1MTHZqcIHZtMqC76+yq8wr/+Q2m8F07frShrwyKT43ANHewyyv6lymUWlZ0J?=
 =?us-ascii?Q?WGOrhb0+eDIJs33MzR5zp8lvVI4fNEEgG1/KhzZ+a8u+4RlJT5P1+AnxbxuU?=
 =?us-ascii?Q?6r+LR+ieMllgYFz5P9HVhHnyOgbS5BTmPFQOrqSRe/ekljMBb/ywIk4EvlOW?=
 =?us-ascii?Q?038DYIIdhpLeV9uyzv/O3qUFluVRznNVD8J264BRhDt2xXB+5eOK63XYMTlX?=
 =?us-ascii?Q?f5vZ0x7hiAS2YujmKgL6B5bYwIokVTnQ3lZvnjtPhqGjCrWJtvON6pV3Dc0q?=
 =?us-ascii?Q?e0j0VazNGJx3oe3SNXd76ToiK8beWXAv4aTJ1AnOX4McI6MDe/stygUIWWck?=
 =?us-ascii?Q?ycZCiK1fgPeRy6rw9hokzxD1dBUTv1X7hqer8FIqpJt5cEGOebD3hR0w1Cf/?=
 =?us-ascii?Q?YC2I5t4ZDouQyQx/GDOO47upEhdGB0s1Yh2lk4/SyO+5k2H7DxnjbjtsjQFQ?=
 =?us-ascii?Q?Vhl3owtKmt5c/+BHTmnPehP8vBxuDXVEbueOPkDJu0T+/MzA+0uBf3PXFvYY?=
 =?us-ascii?Q?1oqW/8Q4fCB9aqcH6SVCU6cau5nfRkV+iAj5tn9F4QvoTgN1hZiN3jmk/uiL?=
 =?us-ascii?Q?mtiG6ocCNlD1qN7nDXJ3QurNhiYh3PdfOFt980ef58eq+zOTf0S2nf4DGcf/?=
 =?us-ascii?Q?Ircv9maW7/LhucAN4qxazwbd4W+RNYLdNNlf0R6O07+j6EqJPMIZ6YSNTxAA?=
 =?us-ascii?Q?2UpD+zZ7CY5HEG1LKrcuMg1luZ7pr+SkJisY+HuBX0KOBQylwuQCj9ID1/N8?=
 =?us-ascii?Q?pavJ7R9mQ7usUUBD5Mwi6V0inPFf85iewi/EPyS9okFvcSUG8+ttgBwWTovV?=
 =?us-ascii?Q?cdgXaoh021olswrpDepMgwGVNL6UAjNUE6Rm2SwFUya6JKUNDvzXZ7dumgta?=
 =?us-ascii?Q?FBtmD6LUMVVYyA4fRCdzd1GPrgARpYGWYXoWYf0mMe9fS9KP8Q4l/Wtwu0EK?=
 =?us-ascii?Q?muu2dvuCEg4IUBFnDwQNFT2SBl7Ixni3z1eigjzPNR/GSpL/YmVuKCKBCGwb?=
 =?us-ascii?Q?8foqB1uYzQ/TrVvYwTmkWesPfmQAFdTCgsCeN8EzTFd1S16VgtQL5P/VTr7l?=
 =?us-ascii?Q?1UGR/KfZ2ozyuPukOGr/C1QvGtELmlpMwa++0NZTQqzTTv47/mlN3H9Jblq4?=
 =?us-ascii?Q?Qn/0gKa93n3FP8Q/WV/mPgxZPKgUacCGlo8bpabtH1C1tj6GnR6/TcbVXnT/?=
 =?us-ascii?Q?ApwrkKGxdP3X2l9xgslAcEAY54Dzl24o12G+DLGAX2DNrWYzTrXSheiQ+Yi1?=
 =?us-ascii?Q?7ySc8WrEjWf86aPFFyUN5lzP0y68cN5vrlnu+XUXdoxWeSpJT+Ah5kDByGPS?=
 =?us-ascii?Q?vDVMoYoL4L7cxirpNKdmF3us6Pxh3BOD+6fPheeH0pkkw4+zZ7QpgE3jnqrY?=
 =?us-ascii?Q?5ND27q+0DzSDt51eDnFNBlQda8kKrwjCjB9UfJuvLOiwYRsKRW9keywx798u?=
 =?us-ascii?Q?ycf6911fHfaALqus61+nM2KN52x0XUtacJTHHS3q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ea6a0d-d592-47b2-534b-08db1fd4b7e0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5979.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 12:57:48.4485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zAdMgmo20gPCrXMKixltqpfONx3qna4mB7P+e2XInWQLY19aoslPFEqgZIO5IKxl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4188
Subject: [virtio-dev] Re: [virtio] Re: [virtio-comment] Re: [virtio] Re: [PATCH v10 04/10]
 admin: introduce virtio admin virtqueues

Wed, Mar 08, 2023 at 01:44:18PM CET, stefanha@redhat.com wrote:
>On Wed, Mar 08, 2023 at 11:17:35AM +0100, Jiri Pirko wrote:
>> Tue, Mar 07, 2023 at 08:03:47PM CET, stefanha@redhat.com wrote:
>> >On Tue, Mar 07, 2023 at 04:07:54PM +0100, Jiri Pirko wrote:
>> >> Tue, Mar 07, 2023 at 03:39:11PM CET, stefanha@redhat.com wrote:
>> >> >On Tue, Mar 07, 2023 at 09:03:18AM +0100, Jiri Pirko wrote:
>> >> >> Mon, Mar 06, 2023 at 07:37:31PM CET, mst@redhat.com wrote:
>> >> >> >On Mon, Mar 06, 2023 at 06:03:40AM -0500, Stefan Hajnoczi wrote:
>> >> >> >> On Sun, Mar 05, 2023 at 07:18:24PM -0500, Michael S. Tsirkin wrote:
>> >> >> >> > On Sun, Mar 05, 2023 at 07:03:02PM -0500, Stefan Hajnoczi wrote:
>> >> >> >> > > On Sun, Mar 05, 2023 at 04:38:59AM -0500, Michael S. Tsirkin wrote:
>> >> >> >> > > > On Fri, Mar 03, 2023 at 03:21:33PM -0500, Stefan Hajnoczi wrote:
>> >> >> >> > > > > What happens if a command takes 1 second to complete, is the device
>> >> >> >> > > > > allowed to process the next command from the virtqueue during this time,
>> >> >> >> > > > > possibly completing it before the first command?
>> >> >> >> > > > > 
>> >> >> >> > > > > This requires additional clarification in the spec because "they are
>> >> >> >> > > > > processed by the device in the order in which they are queued" does not
>> >> >> >> > > > > explain whether commands block the virtqueue (in order completion) or
>> >> >> >> > > > > not (out of order completion).
>> >> >> >> > > > 
>> >> >> >> > > > Oh I begin to see. Hmm how does e.g. virtio scsi handle this?
>> >> >> >> > > 
>> >> >> >> > > virtio-scsi, virtio-blk, and NVMe requests may complete out of order.
>> >> >> >> > > Several may be processed by the device at the same time.
>> >> >> >> > 
>> >> >> >> > Let's say I submit a write followed by read - is read
>> >> >> >> > guaranteed to return an up to date info?
>> >> >> >> 
>> >> >> >> In general, no. The driver must wait for the write completion before
>> >> >> >> submitting the read if it wants consistency.
>> >> >> >> 
>> >> >> >> Stefan
>> >> >> >
>> >> >> >I see.  I think it's a good design to follow then.
>> >> >> 
>> >> >> Hmm, is it suitable to have this approach for configuration interface?
>> >> >> Storage device is a different beast, having parallel reads and writes
>> >> >> makes complete sense for performance.
>> >> >> 
>> >> >> ->read a req
>> >> >> ->read b req
>> >> >> ->read c req
>> >> >> <-read a rep
>> >> >> <-read b rep
>> >> >> <-read c rep
>> >> >> 
>> >> >> There is no dependency, even between writes.
>> >> >> 
>> >> >> But in case of configuration, does not make any sense to me.
>> >> >> Why is it needed? To pass the burden of consistency of
>> >> >> configuration to driver sounds odd at least.
>> >> >> 
>> >> >> I sense there is no concete idea about what the "admin virtqueue" should
>> >> >> serve for exactly.
>> >> >
>> >> >It's useful for long-running commands because they prevent other
>> >> >commands from executing.
>> >> >
>> >> >An example I've given is that deleting a group member might require
>> >> >waiting for the group member's I/O activity to finish. If that I/O
>> >> >activity cannot be cancelled instantaneously, then it could take an
>> >> >unbounded amount of time to delete the group member. The device would be
>> >> >unable to process futher admin commands.
>> >> 
>> >> I see. Then I believe that the device should handle the dependencies.
>> >> Example 1:
>> >> -> REQ cmd to create group member A
>> >> -> REQ cmd to create group member B
>> >> <- REP cmd to create group member A
>> >> <- REP cmd to create group member B
>> >> 
>> >> The device according to internal implementation can either serialize the
>> >> 2 group member creations or do it in parallel, if it supports it.
>> >> 
>> >> Example 2:
>> >> -> REQ cmd to create group member A
>> >> -> REQ cmd config group member A
>> >> <- REP cmd to create group member A
>> >> <- REP cmd config group member A
>> >> 
>> >> Here the serialization is necessary and the device is the one to take
>> >> care of it.
>> >> 
>> >> Makes sense?
>> >
>> >Yes, I understand. The spec would need to define ordering rules for
>> >specific commands and the device must implement them. It allows the
>> >driver to pipeline commands while also allowing out-of-order completion
>> >(parallelism) in some cases. The disadvantage of this approach is
>> >complexity in the spec and implementations.
>> >
>> >An alternative is unconditional out-of-order completion, where there are
>> >no per-command ordering rules. The driver must wait for a command to
>> >complete if it relies on the results of that command for its next
>> >command. I like this approach because it's less complex in the spec and
>> >for device implementers, while the burden on the driver implementer is
>> >still reasonable.
>> 
>> But isn't this duplicating the burden of maintaining dependencies to
>> both driver and device? I mean, device should not depend on driver doing
>> the right thing, that means it has to check the dependencies for every
>> incoming command anyway. The only difference would be to wait instead of
>> returning "-EBUSY" in case the dependency is not satisfied yet.
>
>The device does not need to reject commands that have dependencies with
>-EBUSY. The result of commands with dependencies is either A -> B or B
>-> A.
>
>For example:
>1. Create Group Member A
>2. Delete Group Member A
>
>Command 2 might succeed or it might fail with -ENOENT because Group
>Member A doesn't exist yet.

Yeah, correct.

>
>> Device knows exactly what are the dependencies. And I believe, those are
>> device implementation specific. For example, some implementation could
>> support parallel VF config cmd execution, some implementation might
>> need to serialize that. Driver has no clue.
>
>Yes, that's up to the device. Out-of-order completion is a superset of
>in-order completion. So the device is allowed to run commands in series
>when it wants. A driver designed for out-of-order completion will work
>fine either way.

Agreed.


>
>> Could you please elaborate a bit more what you mean by "complexity in
>> the spec"?
>
>When adding commands to the spec, the dependency relationships with
>other commands need to be thought about and documented.
>
>Device implementers need to get those relationships right. That means
>they need to remember that command B waits for command A.

That's my point, this is device implementation specific. Spec should not
define anything like this, that might be limiting in some of the cases.

>
>Driver implementers have to understand that command B waits for command
>A but not command C according to the spec.
>
>That seems complex to me.

Sure, I agree this does not belong to the spec, it can't, really.
For the record, I never suggested it.

I think we are in agreement.


>
>Stefan



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

