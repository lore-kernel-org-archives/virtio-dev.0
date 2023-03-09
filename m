Return-Path: <virtio-dev-return-11560-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A408BC61DA4
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 07:30:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E2B0029FD6
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 07:30:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D30E9986720
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 07:30:50 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C5D85986708; Thu,  9 Mar 2023 07:30:50 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B069A9866F3;
	Thu,  9 Mar 2023 07:30:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HI32Igy8ScV1YjF5/4nBLQCG1nAmb9+BycUGxiy9fu94NTlJEizCjk21LZSMYfYUwI5pSTWd0ZK1BMOUN1QyQhZKZCLR8EPhsW099X1EX+Q+FKqgeFkBrjBt2exJhUG+NcgscgfWejdgha4gQ6r6IzMnIMoog8LwtUFOgTsfwfNBOd1gvzspzVnfYPUiPQa5EKRPyuxgE7nQnhlbnPWyVaSaYO80KIHzhhNBimQC3tD9SSpu/KBXGcWP9qqJoKOtK9CNhboO/v3jh1QmPTUThl26AZQ8C04+vDqBykW8i5NA0VVF6ah9CYAOTseCGZzeEB1wnONSq6rAVg0niufORg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Ckiuj9SMxfXYk6h/XKsRlTNr4owowLVB0d/guEoi4Y=;
 b=hXExcI2LmAAsGA727f7jiF7cSpk+/GVRqP+hJeFuseH3acDua1jAo+bR6wG3W0ClaVinY6zK5vbYrOHqrvrmAVSxQoXLRgwaIxM/5Nu6WcocSwsSg5qm15eALHEeqW3KJrjggM2YCF7Pslp7eY1yHFXZQCNB68y9f+vvdju5pRwn2T4963uMX3SylJaanN7YrFiTfPusnPE8f3XUgTf1TPAsTE1VRonvzVdLBdn4tSJJBwvExEtoofABqfJiPsyHKRQiDiqyb0+idsnubal/Ic3yUr9xqLV5uoW9NFugNRdpAC4J4z9Ozy7EgXMuswq4wztfYjGrc4oX0Fvm1eaBbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Date: Thu, 9 Mar 2023 08:30:41 +0100
From: Jiri Pirko <jiri@nvidia.com>
To: Parav Pandit <parav@nvidia.com>
Cc: David Edmondson <david.edmondson@oracle.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
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
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <ZAmLIc97Ud09YfGT@nanopsycho>
References: <ZAXfegxCfvfLwiJT@nanopsycho>
 <20230306133816-mutt-send-email-mst@kernel.org>
 <ZAbpiRVdo8BciELX@nanopsycho>
 <20230307111458-mutt-send-email-mst@kernel.org>
 <ZAhdzCd6qwWydesz@nanopsycho>
 <20230308064505-mutt-send-email-mst@kernel.org>
 <ZAh61E/wQ/hSY/OI@nanopsycho>
 <18d51bc0-d759-1a05-cb7c-3d46c4ed2f1a@nvidia.com>
 <m2wn3rxgv5.fsf@oracle.com>
 <PH0PR12MB548150700B50006F9F174104DCB49@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR12MB548150700B50006F9F174104DCB49@PH0PR12MB5481.namprd12.prod.outlook.com>
X-ClientProxiedBy: FR3P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::15) To MN0PR12MB5979.namprd12.prod.outlook.com
 (2603:10b6:208:37e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5979:EE_|DS0PR12MB8526:EE_
X-MS-Office365-Filtering-Correlation-Id: e11af6f5-4296-4881-487a-08db207032ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WgZi5FUW1bwTb9ZW7KOFeEnIwY+iJsW79B9WeeFhN/4lbgb82hkW9Q39e/80JWVLipPQnzLsUGC+kIqhJ32blbzIUOiPn79xCe0JMTtGRJJH50Z8xpBH95yxEjw7zGLyKwjjFjVbWub1H8PqtQpWqUX7dMYYMYACWyA/FVUnBEE/q19cXxRa7BYa+g39EZaPoYUZlxBO/OuCuw63IvwGzzJrHiAUY6SdFVeV7HqBI51fnJGBG7AehGpj+5p+rey6taSkWN6QTgvkiyhUMdEiWrzmpW8WT8fflrYwj/pqdpNDFBt59OODGTZMLlG8R5QreDmwr9B4csrxxOfyY6XS3Mj/aGBCeAt9rizLmAJZ0xoI5ZxZNKU9FPfWGAG96fvguFGXRJVs84QjyK8vHXOmtBZpEAksHycpUwTY/EhWME6qi5c1gpy2pftKvURnFhEAJRjCNeGgtSUy9fgXlnLzpWFDg9xp7F1LqFQy7GO5NVv6xmPY0aUHG13GOhnZFDqNIhHl7hSWTqBWahLSGC7o67QmdMXfvqhpmZW36fdkJ54udhOmu0PwjQHP1YKQGFXyR80a0AkEeKWYGS70x8q3A1jVhuCfhEcWNItij8XKhfwjHIR0ytcFMSV4EuZOC/ispcqvs0jtQfsODsJ3uMyylg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5979.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199018)(5660300002)(186003)(66556008)(9686003)(8676002)(7416002)(66946007)(66476007)(6486002)(6636002)(4326008)(6512007)(316002)(86362001)(54906003)(6506007)(41300700001)(8936002)(478600001)(26005)(6862004)(107886003)(38100700002)(6666004)(2906002)(83380400001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QZ+XdTnSLvAgb/qnnS1cFOYhJzrBqx3Q609PeA61GFPr6WXDrIaZ1l/eiOmK?=
 =?us-ascii?Q?4N90ODIVTqHUEAB6UI1IiGgfS1pkedC+QpbDdC56BrjJZxcsyF1vKJhsY+do?=
 =?us-ascii?Q?Er6xX6NZ4eSEaLxrQyTpse9nwjfEIX5Kw+KUepxZqcwbahpEi0N4L/wDHokY?=
 =?us-ascii?Q?Z5g9CoJT85coEHc9ZUElbB8vsiDRvY0WINP6lVs3WE7sjys/On57jB/8CkjE?=
 =?us-ascii?Q?y7ULTTgRlCce/5BLlV5ShxNSwN2F1XYYzcO6JADO/lAirl2NfNO3MJ4CfH7Z?=
 =?us-ascii?Q?bmZbLxGQWAwpzu9YbZ71m3dZVhsN+kBPAIMGQ0K2DZzV1hCSSnU3aM50U00G?=
 =?us-ascii?Q?fg11LEaKGqsGjkG5OHg/yUbISRUaI1+iYLR9/Gyu7J4zuX86Y73FtHgV5R3s?=
 =?us-ascii?Q?J/2FU8rLKyBwqYBKRKLIOB/UWXlgf+tBl3CsPWfr6YomwKhjf8oQrM25/YSv?=
 =?us-ascii?Q?GzTcyo9w83XR5nX9+cSM0eeKEE5c/Dkr7JceAWYe51mY8rdX+R/glfgG1hOZ?=
 =?us-ascii?Q?WOFBLVai2Bn85N9O89TNcvwzYyDoFjgKTBl/8/TEkJvDUNgsBhjVBFiSPE5C?=
 =?us-ascii?Q?geTMvH5Oaqbq13XMyfK3Sj0AzqI2wz8mW70HPUd8ioWX93brkU9WNsYjjg/+?=
 =?us-ascii?Q?5xS9DxDrelUfqWOFWSKk4ImpivJUDheimB+MdXUtMV37Y9rggrOyXbDAWzhq?=
 =?us-ascii?Q?JGHE2XWyU6uzHXZk7GzZXnxcMGdekisjvNoh2JfEiEfHmeFb8v+xf1L7Eatt?=
 =?us-ascii?Q?8WXhhKuBrIkiVgKyrofKoybjXyrTHdk3U10WP95v7v6cctU9cnAVreV8oTmF?=
 =?us-ascii?Q?bxt6QyNiiGg0rFbAOxEZmwhzPoffTqPCZoBf/sgWDEkebVDo+IshJJepmOWd?=
 =?us-ascii?Q?h6d+VJXAUQFT1Dg14qQSrLJeeX5p6vWfQFrK8lRGVg7mRsQf3l+pqSuQ34rA?=
 =?us-ascii?Q?ig9mAIDwRfFSoPTftiLtA0fQzc+uENeyi+fkmgD821FXbkJ9dKsroAYUj/Xh?=
 =?us-ascii?Q?xW5uCjfU4oJONQdPXkqdHcKSFSyQ7noRvpfM9DgZCEd9AM78Byze1kEpgf73?=
 =?us-ascii?Q?8s8A/MxtI7Do2XNjA17GP9icqJXv5kLKEMBoPIpl8S6XG3pIiqfbQWGMqjVg?=
 =?us-ascii?Q?BAsBpKiOOvTE/hxs/0U1VEP8XO4jQM44YdnzO1P5a/Lx5JhvYWG4HnBlaPu9?=
 =?us-ascii?Q?ULbUJ8cYu/4Iu7ELDQCbCm6qTTRjoJrlGBXD+fvmSzzxrY8jBiJNtVIhIjHW?=
 =?us-ascii?Q?itMfegrfEgc0YBTdwwINugN16Il8xTjqr4ZO2OeImwHBQzh8t0Ma0Pf13b03?=
 =?us-ascii?Q?M/AfMORs/tl8QhZkGlz7UnHfe+5yhSIuGi3jG0PD+pX/hN9c2WDkUJOQNpoM?=
 =?us-ascii?Q?0ov1j72jTBFxN//YDJx0ahjvnYyHoeJmkBsJb6aqjmMslqWL7GB/QVakUdTK?=
 =?us-ascii?Q?hEs2z1m/mWfRETdeqYg8+aub40upd/y3MUA8XhTdAB2C/o5mg+cnUcAPE3fq?=
 =?us-ascii?Q?mg6yKZ4GD6BQzKI/IQctQ7OtspO/QVOQ/s5fHW5ORi4R0SyASe9/7aZJMaqu?=
 =?us-ascii?Q?DHilHE9BCCUbOJ9Yn2qIAZDCf8Zj6/DnErZ73453?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e11af6f5-4296-4881-487a-08db207032ad
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5979.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 07:30:46.3886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QHrXyuV8IeyBZBQtnyvH6CJaOhlh5MmT4O6LMqBdxcjVxke6zjBItdQywNRMg7Sr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8526
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio] [PATCH v10 04/10] admin: introduce
 virtio admin virtqueues

Wed, Mar 08, 2023 at 10:25:32PM CET, parav@nvidia.com wrote:
>
>> From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
>> open.org> On Behalf Of David Edmondson
>
>> In support of live migration, might we end up moving large amounts of device
>> state through the admin queue?
>> 
>Correct.
>
>> If so, that would seem to have some performance requirements, though I don't
>> know if it would justify multiple admin queues.
>DMA of the data through the proposed AQ is supported.
>
>If I understood Max correctly when Max said " This AQ is not aimed for performance ",
>he means that AQ doesn't have performance requirements as io/network queues to complete millions of ops/sec.
>
>it is several hundred to maybe (on the higher side) thousand ops/sec during LM, provisioning use case.

But isn't it good to design it for performance from start? I mean, state
transfer of thousands of VFs at a time is definitelly performance
related, isn't it?


>
>DMA perspective as you mentioned, AQ still has the same perf requirements as that of regular nw/blk io queues.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

