Return-Path: <virtio-dev-return-11505-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 194C4C678D5
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 10:17:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7B8882A8DF
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 10:17:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 64D6C98670C
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 10:17:50 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 56E329866EB; Wed,  8 Mar 2023 10:17:50 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3CE4A9866E7;
	Wed,  8 Mar 2023 10:17:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gdq8jSHkSKEUcDmE/2S3oIEflcWrMcT7afiRa7IlTRnlLZKfdQjUfFr3nAhlWm9troJuMCszldt8V5hIBffY6qaX/b1dIAoMAh+A47iKuoJTDkGYuknqVIj1/Yq6URESbNv2E5Xch9HyKO0Ehtg58/R3fYXWc0/ic5suvNgpfdz42m1PwzNyPr1GbnfL60mZCyBWaTC7T/Z0+OpN2TSuZWlRJzXr4B1ZzDf/orOhTz2MFQluyYlaSFNy4Zf+Pu6rK+7QL5arjfakPhdJolHbiYqEIO0at+s+rpXRhMrv8SJA15zAMJPx/rQTqMs/WfsaZSkxk/vt+1qUm6zUWqNMTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ee4jH4ego27TSu8JbQFsbB9AHNRO6rJmLkydHIiLBoo=;
 b=WJoPbiwuhUairmUtg0FgzgL8GN860rEqfyxh3Ux/L3MDm9nbXDnyte7MuDNVcVM7z429pnBLGzsRsdPVtxjfxQx4xkVNSuUCVdTpwt683J63CQbhKAXZ1tY4XaE6db2QTGGQAPEkiQfMpqYGQOn19hAw4rweHJK07H+2G0Yi9TgN1UB4/2GYw+br1A5qckFgQ34BIavwcg8UgXQmyZ5AyexTfW7U7gigUWioNfAihOU09y4xEucmD5mIUt36uQrnvgpbGEbROT0WL9Gs//ItZ8FoHHhxvwdRO9K2ZAvKz4qqbCjACV29FDHr3SgEAFtgoROjgOSuGNiFwao75xPuUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Date: Wed, 8 Mar 2023 11:17:35 +0100
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
Message-ID: <ZAhgv21Nnex6vbDf@nanopsycho>
References: <20230303202133.GA2901137@fedora>
 <20230305043419-mutt-send-email-mst@kernel.org>
 <20230306000302.GA244754@fedora>
 <20230305191351-mutt-send-email-mst@kernel.org>
 <20230306110340.GA35392@fedora>
 <20230306133525-mutt-send-email-mst@kernel.org>
 <ZAbvxj+7lgaI1HkI@nanopsycho>
 <20230307143911.GC124259@fedora>
 <ZAdTSiVJGSrRIqZ3@nanopsycho>
 <20230307190347.GA153228@fedora>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307190347.GA153228@fedora>
X-ClientProxiedBy: FR3P281CA0198.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::20) To MN0PR12MB5979.namprd12.prod.outlook.com
 (2603:10b6:208:37e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5979:EE_|DM4PR12MB7719:EE_
X-MS-Office365-Filtering-Correlation-Id: 20b93410-a389-49d4-83d1-08db1fbe58ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+2EX/lwZ5h93dvfResDZqjCG87q42z+GB6e2F2zhrjMIZrLHF4L4d7yG1a25jZyRGwXYuKlxw+aH8BENtPBjKaExX7CBgDNxTaFpkdYEuN6DSPDx9kyqXq4sx2qSViPXBAgi+257KeOmg/DKr2beS6RLuLy7shgUks/gfbzX9OanBVypR+z4YVPiP+QRMynrYTsoxU8SwCcJoW/2uZBrfNsjmJ+9zIsaFG1qMkhqyevoMhDE88XtPYd62BD5nlv27apaG4wF8oMzIWQ5SMBsv5UDll4H+H1ZOVOcBq62VJi9iFftJmd87ayt5kGbQB/+dVPtdzjaRYn1MwBjq0fkb3QMYrgFh1818rEXNafxCNktp6RIRd9eZaK6syHFtEq6sDl19D22a0jvoYhfHMb9iYyLkxkauy8PW/pMVyy3UBVy1eaTM8zkS7U0k5Y2eeoRh/DzKygfiMaE8FRxkJ4x8fjsWtRPu7w7APB5ZXQA4tnaE/OhBN51OIWhOazdvkAEdz2SPQ5FuUfj6Ht7aIWT7cJEXHLSsGacnDn5OfTLMUJ/BQRRsSqE+lZrVs0sRTaNjMqsMkTenN+3G2ZVO4L8Zq1AJ9AqEAJD1yfMja9h8+YczwP1XRFHUeG9w3Q3TRNWCn/UZswNHScf3m4FGy9b4w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5979.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(451199018)(83380400001)(66899018)(33716001)(9686003)(66556008)(4326008)(66946007)(8676002)(5660300002)(66476007)(7416002)(6916009)(2906002)(26005)(186003)(41300700001)(478600001)(8936002)(107886003)(6666004)(38100700002)(6506007)(6486002)(54906003)(316002)(6512007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fGrywULgQf6zApjtnMF5jsz0I5M0JoIMp/y8hbdizn+J5Z/GovgSXo89esXu?=
 =?us-ascii?Q?64CehHJSwxMON/LaE4Bzet86Decz7xky3+Mrxj3XqSzRDcmQJ6ZpouixZfDp?=
 =?us-ascii?Q?8eJ7wjjsNOGULpZ/HqFP9l5HSNeo+PgirCVLODLRJD8qIGFjPdaVD+NsV/iV?=
 =?us-ascii?Q?BpKBN1Z09St4yEvcxoHNVmUohd2Era8Th02O+d8sXwUrgtn8iWKv/RUoITM2?=
 =?us-ascii?Q?lEUW4uV6JJvONsTs2OdPvsto93f7dUWSQbIJz+3ekn1XKNR8K01uOiVTBEGO?=
 =?us-ascii?Q?gLtXkxUad5HM6TgUJVWw5zginRyS5hieac+kurO3fTO+RsJYMmKqhxhmaTFS?=
 =?us-ascii?Q?lJqR2NdQ7AJ5HWI8FEU/j8eRKFGeRNi9XZM4FvLTs03GRaG/31a70kA88tYu?=
 =?us-ascii?Q?/EJs48vZG1LDZO1WKSefTJs80LFKQu2ZK1dnuKtCFzGeBsOCtXtRuuqvTJj6?=
 =?us-ascii?Q?MTncNt+vBY1WKjBB11eyPtCaEArjeqmOyJ4EwZ1EK8KBIUFosgLUbVA7GdEs?=
 =?us-ascii?Q?PrA/n29hzzlaydUCEMxcigKthTPg5UN2N2WSzb9GafZ+n0Hu5oGPXWmFpiZN?=
 =?us-ascii?Q?jA2dPksvk1dactpKVnk4bFAYnmUOUElYWUpqY6fBQS2uwxbWESVAzASsamhB?=
 =?us-ascii?Q?F3IMzFfwq42Rpmox2RKOqtkxGDiIQfoHbQbWv2CJ30325Tz3woXDl45M6Jh0?=
 =?us-ascii?Q?dMHXej2UaVLlbR23qVw/YYmSsgmuXpTARgDUvbA+u9DVegFZBv6hZqUYsjVa?=
 =?us-ascii?Q?ojdUAJFUDHRQpFP5YYtZxx9sIihiubMAhyYpdnyqcFVfxqGe/9okHudOmGp1?=
 =?us-ascii?Q?b2Z4kb1UABBxRHuaaKjNMiRtPr8CtoQ7bo3FzyD4Lkg+HhYYcQCLjWJeLluK?=
 =?us-ascii?Q?zbasa0DGxFJOQFC/jmECvCeprmF77Jz8J+dUK7egmnjc+mVEkj/CzmmZ05as?=
 =?us-ascii?Q?yoU1dxmUXN6zjTnvjmrfdlSCUDQx1PthYsJpbG0K/2Oohu5JsMDsRAsIAOlK?=
 =?us-ascii?Q?CNSPHFT6C6QI7HNap55m3ESdwh3VbqzYl0NyUk2lVJcp1nk44mfsPpIpsD2m?=
 =?us-ascii?Q?iX5p20Ycbj5KP2eYfKUXqqU5TuzlfGs6fI7jjeqoth4IiAyNEyjVVYpHPzrX?=
 =?us-ascii?Q?l2e2j+yNKli0dgWe3L7vAQjHR+whtTEnyncGSlHQVYJmRL1ZFQO8qTYmltw2?=
 =?us-ascii?Q?v8KU49+AQhjQ94rqz3xtkvczHUeFQeEheDMd0JwYh7QENcE0OqK7T8fQ38hh?=
 =?us-ascii?Q?rNXEaXZOWtzmE8TCYLlmUEUdXW3/vQNR38ddLX7uQavb9MV6Wr3XI2jP9FkR?=
 =?us-ascii?Q?uu2nxANdaTRqFQOMJIhBVWUZZBQHWSTUmqSW6LW37Y+vi7KKiIkafSId+TMs?=
 =?us-ascii?Q?maCZ95/PAPl/UAsm1w7LoX6HDpNOEcJf5tWqdI0EM1YUbrH1DjHzG11xjipA?=
 =?us-ascii?Q?y7r3lNSeUKntIJ9KaW93SxGq9/bu2MY0fYtNDmgJOZbm43QfkOGhxgA1oX5P?=
 =?us-ascii?Q?miKWMF8eL3YmrHzAv4DwpoPYSSckOodrCkWRDlvnJ4hUMPfeAeWnJX3FoFVQ?=
 =?us-ascii?Q?xFa2ydYimj4iR6WH9rWzZexmOm8HzeDSHM/34MuV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b93410-a389-49d4-83d1-08db1fbe58ec
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5979.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 10:17:40.1074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lO7nhivULmpqVbDLAm85nwW9LBswRAbd4n6d4rECe1XOfsIowFbtQZiH4ptDILDz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7719
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio] Re: [PATCH v10 04/10] admin:
 introduce virtio admin virtqueues

Tue, Mar 07, 2023 at 08:03:47PM CET, stefanha@redhat.com wrote:
>On Tue, Mar 07, 2023 at 04:07:54PM +0100, Jiri Pirko wrote:
>> Tue, Mar 07, 2023 at 03:39:11PM CET, stefanha@redhat.com wrote:
>> >On Tue, Mar 07, 2023 at 09:03:18AM +0100, Jiri Pirko wrote:
>> >> Mon, Mar 06, 2023 at 07:37:31PM CET, mst@redhat.com wrote:
>> >> >On Mon, Mar 06, 2023 at 06:03:40AM -0500, Stefan Hajnoczi wrote:
>> >> >> On Sun, Mar 05, 2023 at 07:18:24PM -0500, Michael S. Tsirkin wrote:
>> >> >> > On Sun, Mar 05, 2023 at 07:03:02PM -0500, Stefan Hajnoczi wrote:
>> >> >> > > On Sun, Mar 05, 2023 at 04:38:59AM -0500, Michael S. Tsirkin wrote:
>> >> >> > > > On Fri, Mar 03, 2023 at 03:21:33PM -0500, Stefan Hajnoczi wrote:
>> >> >> > > > > What happens if a command takes 1 second to complete, is the device
>> >> >> > > > > allowed to process the next command from the virtqueue during this time,
>> >> >> > > > > possibly completing it before the first command?
>> >> >> > > > > 
>> >> >> > > > > This requires additional clarification in the spec because "they are
>> >> >> > > > > processed by the device in the order in which they are queued" does not
>> >> >> > > > > explain whether commands block the virtqueue (in order completion) or
>> >> >> > > > > not (out of order completion).
>> >> >> > > > 
>> >> >> > > > Oh I begin to see. Hmm how does e.g. virtio scsi handle this?
>> >> >> > > 
>> >> >> > > virtio-scsi, virtio-blk, and NVMe requests may complete out of order.
>> >> >> > > Several may be processed by the device at the same time.
>> >> >> > 
>> >> >> > Let's say I submit a write followed by read - is read
>> >> >> > guaranteed to return an up to date info?
>> >> >> 
>> >> >> In general, no. The driver must wait for the write completion before
>> >> >> submitting the read if it wants consistency.
>> >> >> 
>> >> >> Stefan
>> >> >
>> >> >I see.  I think it's a good design to follow then.
>> >> 
>> >> Hmm, is it suitable to have this approach for configuration interface?
>> >> Storage device is a different beast, having parallel reads and writes
>> >> makes complete sense for performance.
>> >> 
>> >> ->read a req
>> >> ->read b req
>> >> ->read c req
>> >> <-read a rep
>> >> <-read b rep
>> >> <-read c rep
>> >> 
>> >> There is no dependency, even between writes.
>> >> 
>> >> But in case of configuration, does not make any sense to me.
>> >> Why is it needed? To pass the burden of consistency of
>> >> configuration to driver sounds odd at least.
>> >> 
>> >> I sense there is no concete idea about what the "admin virtqueue" should
>> >> serve for exactly.
>> >
>> >It's useful for long-running commands because they prevent other
>> >commands from executing.
>> >
>> >An example I've given is that deleting a group member might require
>> >waiting for the group member's I/O activity to finish. If that I/O
>> >activity cannot be cancelled instantaneously, then it could take an
>> >unbounded amount of time to delete the group member. The device would be
>> >unable to process futher admin commands.
>> 
>> I see. Then I believe that the device should handle the dependencies.
>> Example 1:
>> -> REQ cmd to create group member A
>> -> REQ cmd to create group member B
>> <- REP cmd to create group member A
>> <- REP cmd to create group member B
>> 
>> The device according to internal implementation can either serialize the
>> 2 group member creations or do it in parallel, if it supports it.
>> 
>> Example 2:
>> -> REQ cmd to create group member A
>> -> REQ cmd config group member A
>> <- REP cmd to create group member A
>> <- REP cmd config group member A
>> 
>> Here the serialization is necessary and the device is the one to take
>> care of it.
>> 
>> Makes sense?
>
>Yes, I understand. The spec would need to define ordering rules for
>specific commands and the device must implement them. It allows the
>driver to pipeline commands while also allowing out-of-order completion
>(parallelism) in some cases. The disadvantage of this approach is
>complexity in the spec and implementations.
>
>An alternative is unconditional out-of-order completion, where there are
>no per-command ordering rules. The driver must wait for a command to
>complete if it relies on the results of that command for its next
>command. I like this approach because it's less complex in the spec and
>for device implementers, while the burden on the driver implementer is
>still reasonable.

But isn't this duplicating the burden of maintaining dependencies to
both driver and device? I mean, device should not depend on driver doing
the right thing, that means it has to check the dependencies for every
incoming command anyway. The only difference would be to wait instead of
returning "-EBUSY" in case the dependency is not satisfied yet.

Device knows exactly what are the dependencies. And I believe, those are
device implementation specific. For example, some implementation could
support parallel VF config cmd execution, some implementation might
need to serialize that. Driver has no clue.

Could you please elaborate a bit more what you mean by "complexity in
the spec"?

Thanks!


>
>> >
>> >Group member creation might have similar issues if it involves acquiring
>> >remote resources (e.g. connecting to a Ceph cluster or allocating ports
>> >on a distributed network switch). It can be impossible to defer resource
>> 
>> Sidetrack: this is really fuzzy to me, how the new member is going to be
>> plugged into backend (network). Over the time, we learned that the
>> creation of device from the other side (switch side) makes more sense.
>> That is why I asked for motivation to introduce this infra.
>
>Michael, have you already thought about this?
>
>> >acquisition/initialization because because VIRTIO devices must be
>> >available as soon as the driver can see them (i.e. how do populate
>> >Configuration Space fields if you don't have the details of the resource
>> >yet?).
>> >
>> >So I have raised two questions:
>> >
>> >1. What are the admin queue command completion semantics: in-order or
>> >   out-of-order command completion?
>> 
>> I would add "dependencies/serialization" here.
>> 
>> 
>> >
>> >2. Will there be long-running commands and how will we deal with them
>> >   when they hang?
>> 
>> Yeah, sounds legit to define it in spec.
>> 
>> >
>> >Stefan
>> 
>> 



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

