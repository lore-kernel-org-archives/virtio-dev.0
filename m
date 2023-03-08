Return-Path: <virtio-dev-return-11550-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B727C64EC4
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 18:21:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 92C632AEF5
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 18:21:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 84C1D9866FB
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 18:21:45 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7923B9866F0; Wed,  8 Mar 2023 18:21:45 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 64DE69866F1;
	Wed,  8 Mar 2023 18:21:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CieBUhpWjqtpg/LwOY7IAQDtfndpMeDVrX7F1YkBKmj6bepwZdcBYM4Z5zhWdLRtS6auoUso5+hTSSIFqMArefcGT9p/hLNswy6G0PkYkhB7CDc4KOOPF3KfP2g0bNTJ6TxUMbcdsYGxO6bWSfkE748MEisuihytAPdCPAx8zyCEgD40f7lnBOYh0RRfnuOLPBhrpCQ68dChOtVz2Ee41pOpnO8uTXTKl4ySWSkMtIXTLbzeGp8NjxBqy6ewt1h5KOlMh3j0W8lyh9CInyqNT15Mxwm0DTcY0YoPEpCzgXc2DlqDgawJL+ysXMPQ663u3RIqVLCfyOVr095AtkzEqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8C4270ajBSbIKLzsdQk0wdLowwVqy8dMWMwH7vLOs9g=;
 b=oGX3xzXiJsWA2aOiyZZLbeDWvs8vGdM/6CwaLdhdME/5LzTeHuB1Brwc/rxkPHTExxxOSRqXuKaPM7BjuiI1sE+ALJ+ugTTv3CKRozRuLUarGGEj6EgKay98R/WS+4UUOQwHGP3SvTHWi1vL3gW68mNUQt171YMGTa+KEZvfaY7iJeESOBfi7HauREKPp+47vVMSUfx7p2vlIdER2UnAlXqUF4Jnz31Omt976lVK+qHRpSF8K/VgBaafhWIf3SfmqOX2v4Hhdd3nQaGHAZSqwXJZh0ps2ysdTc4hUEPTWfB6ezVuj1GJU6YezAXcSqw23zSmCGX6jD1ksDWS/jce1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Date: Wed, 8 Mar 2023 19:21:34 +0100
From: Jiri Pirko <jiri@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"nrupal.jani@intel.com" <nrupal.jani@intel.com>,
	"Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
	"hang.yuan@intel.com" <hang.yuan@intel.com>,
	"virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>,
	Zhu Lingshan <lingshan.zhu@intel.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <ZAjSLidbkNHLXPIG@nanopsycho>
References: <cover.1677761896.git.mst@redhat.com>
 <dd9c34ed74ee296228562f6946d4ca3f2fbee1e1.1677761896.git.mst@redhat.com>
 <PH0PR12MB5481595368C8F0C0E16B681BDCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230303032434-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54819AE477640508DCFF8333DCB79@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230308112854-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308112854-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: FR3P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::13) To MN0PR12MB5979.namprd12.prod.outlook.com
 (2603:10b6:208:37e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5979:EE_|CH2PR12MB4232:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ae73936-9654-43ac-b5f7-08db2001f5ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	V7nwUrNEDt3kVxCZs3mSZQKAiJkJWHCLKx91Rw+DnPINk4YZ+wVdzlkzoqEDXww1FIg7xIwJDkxkxyjSHKM51ezgGGVz2kR+4iEgTZDyu8nSR67gUHdQlf/yMbOCb29n07pgu+13aY+pYBuCaxGdHCHvI9BfrLqtypnREWJi3dqFwSxx8/5x0T7yodpIXMyJyGtcZVaUfPEhEjVfTDKn9NOLdBdu79SHx+z9OO+iFCtgXbGS/zgXiYF94wM2OzH745kxG/24C7M4KWkxoQpiJfYtC3HrJZUd1dZlH9jGQB571XYxRXOyH7cE7jI4+GgBdpQGNyMJ641bibFUskFFXe0FjfPH6WXchbOX7V+p2f494Y2ng8bKKo58KEdv5bGGIQLYZoKrCHhU9rvRQ5BdP2WeQpeg55A1I6VTDHwiC1ql29IPPW+fGyyH8jL6ZWcb2bghAHR/xtVIq7yDJD08y5uF/lJSKRU2dftuI0Z/ePkqnKElb5PCqEarq5+WICv+BkAl+bdlXXfTD3R22HbaWuj6hscLvj9YZN5s+VS3pI3rTwl54PgpFbBS4XH/nB9lsmEEfU+c6YzMa/yItsZPh9MxN+PPSC1sA9S+09eJZSM5ZGuPzPX6b3VrIrSqRD02Y4P8ZwiA17HvMkStbbtfHgQ/Lnvit3zHcjEN/0BJ7uvqzrCMyGYMKoxBdKdNpQwg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5979.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199018)(54906003)(6512007)(316002)(107886003)(6666004)(478600001)(26005)(6506007)(16799955002)(66476007)(6916009)(66946007)(4326008)(2906002)(66556008)(38100700002)(8676002)(41300700001)(66899018)(86362001)(8936002)(9686003)(83380400001)(186003)(5660300002)(7416002)(33716001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mC/Y2Y0wieCV2Ym4z79UOpMbPh/+oQrH8OZxAZAQMz8t39CeWyeHmZGUQSXI?=
 =?us-ascii?Q?l4S45r4P6xlwsiMgPclTHezpJR4yFm7PNis5aDPlPp9IVcQfB/8BwF8z7DwM?=
 =?us-ascii?Q?SmKduu3Vf8qd91oqhdAHbMvFgbloId3aCZ+LyXAZGxbWQOrEsJSMC8X3Am3j?=
 =?us-ascii?Q?BVYzKrN13kg66GEJKWVSfxdt2WRMUVTOlN8HAuE1DzChG9LFkh17AOdyt3tp?=
 =?us-ascii?Q?vxxkC/OmnWZpYM4fCRFw6QaJDDa7yc6/lEBSQDnviKlyzH1NREJaOSRXfwC4?=
 =?us-ascii?Q?Ujs8UlJysyosU8JM1INAThXieFSb3MWpMjRFHxKa4cSgAhSI0GkqyyHuZgnU?=
 =?us-ascii?Q?m0UWA/tUhURYaG5UbCFaHzKwxpYYRDuxt42oOjymLSs+xlX8eCDdTliVKIaR?=
 =?us-ascii?Q?EFBbJhS4TE0TSDx6rHw5rkr9SdW6ddbSsm0zdr+BxhXdABE3Iul8ag2kXV4p?=
 =?us-ascii?Q?DU5fzmIE+Cv03XPBYj+RnfDNrNAk37i7GIUcDLVAikm2FoPr4PM3XbI9V2+R?=
 =?us-ascii?Q?6MljGrQHL8DwxFTZlP+wi5lvFp5h8/gGVPYrf6gA5hscd1/g3yzEF7Bepc4o?=
 =?us-ascii?Q?n3oC9gmMDFBrkRi5EXBFaC8vJ8IqsDkvvpUoNIv4gHDMzqM98uDpmhMlAT2n?=
 =?us-ascii?Q?BWvbfh9cvs2iFHkiMCfsrfhD2/0fX5sERlDwFLiq994/TyqLs4w+sK5JaKZ0?=
 =?us-ascii?Q?K4GtO6fvcLEST+4IPgTL6bzeeQ5nj+vmoWs4niAzX6ZGpQTlcu4QI7VoMTbs?=
 =?us-ascii?Q?mrcyKYHr3Wez/ZSBXiMvYGIEdTTaYW+d1IdSdA2dTvsCcRPHIkHkFX91byt+?=
 =?us-ascii?Q?UNkj98KwX6UTlKWbsDiEJ7vrjtaYLYuQvxU9ryFuGdYV9zcaKJ90JwYVIAOc?=
 =?us-ascii?Q?klMiA5R8oxYh3JAH4IIanMU4cSU2QpIGS3AJRt/N5sh9bSwxlGtSogzlvBND?=
 =?us-ascii?Q?a4cIX+smtFXtMexrAi0BLBdFCSooYqprGsMCt4npy4DXj18IY/vpax1BHrBF?=
 =?us-ascii?Q?blm2dEJlSa7dD5LOpr2Mw+9pYdxeYDWdJ56O01LeStL319Q90nyYIt2LyVHK?=
 =?us-ascii?Q?CcyfXS3gS9zaIDtkbEtDJ2wjlq0RSFAZ9/l/rN1un2P1dqJoR9/sqZX3vbCs?=
 =?us-ascii?Q?Cg+1RK3ZNvgPzSDMNuzEK0hMgIoXKt8TvlQ2bd3I9x1wnqYo0yKYtr2dbtXp?=
 =?us-ascii?Q?tLTfh08woGmdjr8OqHJf8xzJ0DQG+YF+yXIqp1pGmwo5JUUEY+I2gM0oBHYq?=
 =?us-ascii?Q?zbYXqTc5pHxWSjh4sOzFfyUVWYH8iopUOB2tSj97MFE9l3ip9StyexdVudPy?=
 =?us-ascii?Q?atB2uDJIse0swIQwX5//0P0kAA5CnYP13vW/3+8b0WuhdXsGMG/WlyXqzkAy?=
 =?us-ascii?Q?3vt9FV9/61y2Jptl3kCF+VMVZRjY1t1du77CjTLlALxCOrJkynvzsAuoD2M2?=
 =?us-ascii?Q?GIIHlbIHdHUq7N0mS4lWBDMleezAMY/pcXI4D1RDWHrKgmOUuzOTHMk8ZKEP?=
 =?us-ascii?Q?d2gcqfJCB8Z7Mwanq0LUeuoWTxTc9iVXaIqbcLjF4C5wA5ON3DJ2MB0GK1Qu?=
 =?us-ascii?Q?9hGLvrHCLKpbQXVksDOgavzA39OMyeAWaP82q5YO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae73936-9654-43ac-b5f7-08db2001f5ef
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5979.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 18:21:39.7178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GbxLs8YdklphnKpbNcb9chETnC7qbzPmjrPBGabSe+xEB915mKkSG1tzsu3Iy9GD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4232
Subject: [virtio-dev] Re: [virtio] Re: [PATCH v10 06/10] mmio: document ADMIN_VQ as
 reserved

Wed, Mar 08, 2023 at 05:30:21PM CET, mst@redhat.com wrote:
>On Tue, Mar 07, 2023 at 06:52:03PM +0000, Parav Pandit wrote:
>> > And I wonder whether it's worth it - it definitely makes contributing to Linux
>> > harder, and even within Linux it pushes contributors away. 
>> The number of virtio spec contributors are in order of magnitude less
>> than Linux kernel or just the Linux netdev.  Patch split up reduces
>> lot of time author and reviewers.  For example, interrupt moderation
>> at v10 can be very easily split up where prep patch can have RB tag
>> and v11 doesn't need reviewers and author's time.  Your work here with
>> 10 patches is yet another good example of it.  I remember Max and I
>> started with 6 patches... and current 10 are more useful way to split
>> them.
>
>It's a big project though. All I ask is that we try to be gentler
>than netdev to new contributors. If there's a 10 line patch it is
>not necessary to be pedantic and ask for it to be split up to
>a 3 patch series.

One patch per change quite common everywhere. IDK, I don't see why that
would be a problem.


>
>-- 
>MST
>
>
>---------------------------------------------------------------------
>To unsubscribe from this mail list, you must leave the OASIS TC that 
>generates this mail.  Follow this link to all your TCs in OASIS at:
>https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

