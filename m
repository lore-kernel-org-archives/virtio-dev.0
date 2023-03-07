Return-Path: <virtio-dev-return-11470-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E99BDC678DB
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 08:03:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2DB2E2A8F2
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 08:03:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 03A729866D0
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 08:03:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E28DA983E53; Tue,  7 Mar 2023 08:03:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CD6369866C2;
	Tue,  7 Mar 2023 08:03:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZd4cP4PgyYr58CZB3eFR/7RtIl6jHzLP23fzGrfkvjUAzSnzdx55vYKFw9Y2ymdl2o1BmZOcT4ncUxCLP61kpmaM1dPUAEEGWyvXP4a2/f8t2UPeAWec2UXSiBwUyZoEvgO1jgruM8mu7EpG04eSd6nS9tcAKD7usDQ+p4GPASM7AEUgWSVffAXW7c3n6f6Xau5GUkQBqxJhWEf3rkqbnLC/VEf4wD2qhA5BW4VAmBb/oNfMx2MHkS2cqw80QOpTvw3iZYNqVYPXdEbmMWtWShtyao1j/PV2SVmUBvOrUigRjMOvXVShc2NM5GzAKGsCBlsP8YtRF5eGgRhR3BNHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Ro84Z7kKRfcCMZt8TVK8C3oN4dOl3a7y5GAdW/eJww=;
 b=Vfaw9bqzFy/ui+eUmCb3S2JiP2K/4ePpxOakN8XR5k5BIepJwmmmBsV1RECGNzY6g5v5YAOrJ9GyH8WIWww9AHiWgCuNwGH6VW2zIrU2976Bv+ZEtVSG14gWcM3J0T3lPUTbtmZUiKrEwxF2K/xQq/LWJ438aoa1crVQMvOXPqpom7hjt7hijPGEw/POxrTQkr5Qlr1nua3/Loth9arckIcTr49kjMiUTIkQOm9oIx+vmf9Xh56y+gxr3ONkLewX8zLREOiy7knw4mfC7UYQBqrE7Uueem+GzGFDzKJ5sBrXvUu6sJVhZDlezHg3Nb1R7q+MVHU+3Vt2TLWA3Rck3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Date: Tue, 7 Mar 2023 09:03:18 +0100
From: Jiri Pirko <jiri@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org, jasowang@redhat.com,
	cohuck@redhat.com, sgarzare@redhat.com, nrupal.jani@intel.com,
	Piotr.Uminski@intel.com, hang.yuan@intel.com,
	virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <ZAbvxj+7lgaI1HkI@nanopsycho>
References: <20230302204007.GD2554028@fedora>
 <20230302190230-mutt-send-email-mst@kernel.org>
 <20230303132840.GC2866370@fedora>
 <20230303083213-mutt-send-email-mst@kernel.org>
 <20230303202133.GA2901137@fedora>
 <20230305043419-mutt-send-email-mst@kernel.org>
 <20230306000302.GA244754@fedora>
 <20230305191351-mutt-send-email-mst@kernel.org>
 <20230306110340.GA35392@fedora>
 <20230306133525-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306133525-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: FR3P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::11) To MN0PR12MB5979.namprd12.prod.outlook.com
 (2603:10b6:208:37e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5979:EE_|SA0PR12MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: ed389a0b-9b81-4304-80da-08db1ee26bfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lKN/Q1LbCydVdIIBhKJSM0AbFiO55sLKg+zlted9ZwwAztcATZSiZTkBt/U1yGEnk9fRoB9kiHItvfZFOxCOKp142pghCC20IpA5JKF3ObFGMBnQ1LX5pBNWKDypwHkcznLcrkXBUInhWB9Yymvh1AL7LieSp+60lEM6rd0wIZWrFmfaISmxiFGNHqEtkWkhkzEiwoHiV8j/JXM8OFCr58+XsQy5olgPH1FqIpxzQR4yGq3ww9Apm6OhdP2jneXJIPYDb6/QdjbnjszCqUr0aiOG6+L4Jx5IW7WMO0Cuk3nXE/9p9VM139Y679pmLjichpGbIJwFGpX20ubOGanpM4v3rQn40s45tiKiU8ouA0A9UrPJ5FSH4IQVRo0CcbCyinmDfm/5hdMBz7EJEB+YaMde64A8H4sJ29PARhi8NCsx50Ydfh7KO6wW+19kt/37CnVi++3Gc6BJ1y3jGUanw+JNOw08HFW7UbhGzFUE0i4d3J5sDkmjW1gKNUy7zl4gJtov5RSRThoT6875KcufjDLJ96J5t5f89fKMdVwhHkEvHtCvte9F10IQ8SXoZHxn0IwITyPLCe5/y3rZyZK1leOom1bRkO8B0R8NBjSl8Kv7DXBwZY/8sNMpdRuf1oC+Kd7NzNvAyawlbY2IOXeY7BubAN8xqQc+nY/o1xqy56I6qsYctvG2aln4gluqBPtirBtZXMkCo0Bjl48j1fjzV36UmsQhnB8CBa4nomItlEYcrRd+N9lcjSYWWN1b04jOSBWbNRivRTnjsXBrcWsCdA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5979.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(346002)(136003)(39860400002)(366004)(376002)(396003)(451199018)(6506007)(6512007)(6486002)(966005)(6666004)(107886003)(83380400001)(86362001)(38100700002)(9686003)(186003)(33716001)(26005)(41300700001)(66946007)(66556008)(66476007)(8676002)(4326008)(6916009)(2906002)(8936002)(5660300002)(7416002)(478600001)(66899018)(54906003)(316002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hHvKg/+d97QIo+XlsBCCEC4MniZioBb4FY3dJfbhkV8geZWi634GC8AsSeWv?=
 =?us-ascii?Q?fK9JEZzarSPZotTP7yM4y3tmPaz1djPjIoJbBFzRZxOcDW+pyMZWQKM+ZzPx?=
 =?us-ascii?Q?0k6LJYrj86qIH1knhslypqnRqhrsoWNPHXHY54+RJxVmW2iTiXQ/jNmRuycy?=
 =?us-ascii?Q?cZDf1BRpW++qeLVfj+1H6tXY6mk5SoHOUoF+AglAjCs47Zt46ral+D2WDzuz?=
 =?us-ascii?Q?mEzSah15OqKDQa4tTvj021vCgZEDfioP5pt3q09XFIE2d1HspNa93okWQlCS?=
 =?us-ascii?Q?vRiu/grWqpAp1SSzIglfru5mdX+OMTIbiEslmDi++drhWZgzo6OsY8ZLKz5E?=
 =?us-ascii?Q?YYepXkmXXRbeTByyHvrYNDSUoVW4I3jxnzHkv0yBIVx3UMpE6RbIWVH/8XxL?=
 =?us-ascii?Q?izJ+zW9iR/idmWqG55qRiJKvZTbndAGBWHMhGxe3m+bd6be5jgH+HW/RhaKe?=
 =?us-ascii?Q?iGp7MK63J5+JT2NKk/dS3xB6KSV6l2rUBSdEMlD6l26VRw0gjeStAw8akP8t?=
 =?us-ascii?Q?vIxpAmBk5weZiQ4fdZL3dldZHHtJPBTE5eqggRfo4tM7lY16k2lqCVotw9e9?=
 =?us-ascii?Q?hujR6HEoXCVC9IxguucfNZREJ1eSMsw7XWKbFscF5BUA4dchneX0o82P5TYR?=
 =?us-ascii?Q?KmpaUVn4tqk25pqbPpOvzYybRQ1CawZhhrmh+PMRQ523sGFoSLYFvmbfBv6W?=
 =?us-ascii?Q?u6ISBoaYP6s2E72LCZ3PJkAJfY3n81Y3HlZ1vtOCxRXi+Dk+G3WsBPzBmxBO?=
 =?us-ascii?Q?jlGyjTqIHq/MzvLddxNNIjVj2Du8HUNeDLDEc61Jt1Xl3QTUAu17E37/uSKY?=
 =?us-ascii?Q?h6XxZHGI/O5b28KveQFogcMAX7rdIcQ6fpEQO7fm5jaZf1Y2PQSleVpjNaua?=
 =?us-ascii?Q?TLQgli33IXMVQ+Z2AZ0ijtqrC4fpv+qw84MALfGYgW1MrukcRXdMghprFKEC?=
 =?us-ascii?Q?YkjZzPBQIW//jJ298TVHSS7Pl5W7zCe2wgbxhAldo/5yaxV4fvcaWTfuTE0N?=
 =?us-ascii?Q?ZN382km/VqCICbLwoWDPJHCEg7XGeZP9uRXvDQA3bVHjSKcGiVuGiPSg1F05?=
 =?us-ascii?Q?9tyClbGnOXJTlR8U6zRXa5szmk9Jgomkty8U55eQLSbaNqi3gYr4dGyBZ401?=
 =?us-ascii?Q?p9wh5ija03pODM7J6DE4uG7GJiAi0O9NklStKrnzW+RzZ4PQQ71xGlOWyZ5v?=
 =?us-ascii?Q?JIBGky4ze9wpGufgRzuUdiitkKPzTu3NBt8CZSpGeZ0yXZ2jqqQdquj4a3a+?=
 =?us-ascii?Q?2/VQyjwYp6Rf7aSciDOQpoHFOkztEVnSaZSptWrVR+pGe05hJLEIyZRP0b2w?=
 =?us-ascii?Q?ejd42nYtAtad590mflkutKDKv6kr8NcVyswklANizdMUazno6YitCGCHx3kG?=
 =?us-ascii?Q?p+UBGYkGzxwsgS95ocd8iXZjFXKi4gNzVOfwWVGiCLpWkomLUrz7n7AB5Yuv?=
 =?us-ascii?Q?YGgMCRVdDjySR6EyOe/NcxkXSGsNup4h9BK/XcB4sM4R1iqivI5RVmfvlqQ/?=
 =?us-ascii?Q?3xPU67rGPDjADScdLfxgjyQxSYG8IzyTzzhzfeqCfh30d69Ly/4fNXXiE/0z?=
 =?us-ascii?Q?VajO2uuW/iJcodeemtgm7TSqBNSpxU5RWK+GgvQh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed389a0b-9b81-4304-80da-08db1ee26bfb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5979.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 08:03:22.7706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0puArwnvlUUiIKe6bp3J4x+Istxefik1NdG+KDwGP1hXPLNG/wHTuQdCyKzeCM5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7074
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio] Re: [PATCH v10 04/10] admin:
 introduce virtio admin virtqueues

Mon, Mar 06, 2023 at 07:37:31PM CET, mst@redhat.com wrote:
>On Mon, Mar 06, 2023 at 06:03:40AM -0500, Stefan Hajnoczi wrote:
>> On Sun, Mar 05, 2023 at 07:18:24PM -0500, Michael S. Tsirkin wrote:
>> > On Sun, Mar 05, 2023 at 07:03:02PM -0500, Stefan Hajnoczi wrote:
>> > > On Sun, Mar 05, 2023 at 04:38:59AM -0500, Michael S. Tsirkin wrote:
>> > > > On Fri, Mar 03, 2023 at 03:21:33PM -0500, Stefan Hajnoczi wrote:
>> > > > > What happens if a command takes 1 second to complete, is the device
>> > > > > allowed to process the next command from the virtqueue during this time,
>> > > > > possibly completing it before the first command?
>> > > > > 
>> > > > > This requires additional clarification in the spec because "they are
>> > > > > processed by the device in the order in which they are queued" does not
>> > > > > explain whether commands block the virtqueue (in order completion) or
>> > > > > not (out of order completion).
>> > > > 
>> > > > Oh I begin to see. Hmm how does e.g. virtio scsi handle this?
>> > > 
>> > > virtio-scsi, virtio-blk, and NVMe requests may complete out of order.
>> > > Several may be processed by the device at the same time.
>> > 
>> > Let's say I submit a write followed by read - is read
>> > guaranteed to return an up to date info?
>> 
>> In general, no. The driver must wait for the write completion before
>> submitting the read if it wants consistency.
>> 
>> Stefan
>
>I see.  I think it's a good design to follow then.

Hmm, is it suitable to have this approach for configuration interface?
Storage device is a different beast, having parallel reads and writes
makes complete sense for performance.

->read a req
->read b req
->read c req
<-read a rep
<-read b rep
<-read c rep

There is no dependency, even between writes.

But in case of configuration, does not make any sense to me.
Why is it needed? To pass the burden of consistency of
configuration to driver sounds odd at least.

I sense there is no concete idea about what the "admin virtqueue" should
serve for exactly.



>
>I'll just copy
>	The driver queues requests to an arbitrary request queue, and
>	they are used by the device on that same queue. It is the
>	responsibility of the driver to ensure strict request ordering
>	for commands placed on different queues, because they will be
>	consumed with no order constraints.
>
>replacing "request" with "admin".
>
>-- 
>MST
>
>
>This publicly archived list offers a means to provide input to the
>OASIS Virtual I/O Device (VIRTIO) TC.
>
>In order to verify user consent to the Feedback License terms and
>to minimize spam in the list archive, subscription is required
>before posting.
>
>Subscribe: virtio-comment-subscribe@lists.oasis-open.org
>Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
>List help: virtio-comment-help@lists.oasis-open.org
>List archive: https://lists.oasis-open.org/archives/virtio-comment/
>Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
>List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
>Committee: https://www.oasis-open.org/committees/virtio/
>Join OASIS: https://www.oasis-open.org/join/
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

