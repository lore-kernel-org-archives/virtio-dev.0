Return-Path: <virtio-dev-return-11465-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864E1C678D4
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 07:17:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BAF9E3309E
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 07:17:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B1C039866F3
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 07:17:20 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A5F36983E53; Tue,  7 Mar 2023 07:17:20 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8F9259866C2;
	Tue,  7 Mar 2023 07:17:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EL6nOKJIn42BtmfdC6PqmYbjxmHO99jVIqs2/Oek0SkI8bsLim5vx5wPPq7ETM4MHsjnUypQsdefBozOj/HoyQ0dMprPcGlFkg+xGLjYl2D6bpRfiYp7fN3cHC88n++KCHSofARpsfkcqXTjYD0rwhSJD3e3djf38jOB+xS6tOtjapT/pk9w9s1/Tg+c9y2ez8KhPI9PSDi8dvD41oGv87Xid2+oUJvRQ+ywLdXOlyQO8uHa4+r2tlJAIbdofbhMi5vcrSgWIj5fo6H9kAA5Za3RaiOef7HoCUIQ+vWpWp83G5jt+0pAnjrjwNBgxEhn5Ldfnx0GB0w9MvYe/RXZww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zbRfeF4/S+0AgZpDAHuOWrOI6HnqTbiv/NphxH8ThQ=;
 b=I7I+t9HKmlniCYaXr85X5sB2ZDHG2Hguv21akxGtWo6kO1xFMktvdZp4ey6Osi64LRWbtE5lFAK32BzkPbTbw5HYDymAXttqzr4PykiZgT1pXTXYsx67+xmj5X8MpP0yh0Ln1udvhLcVTCj+CrfqD9GUJf0ZpkeAUQUsMxjxgOOI5AXc9SBoCLbfkkiAM1I3xiBiC1uZbRCqwh3cuUXGeoas4sIBy/qwuHVVQLvPufzGITZ3k/Nw7VgMCOsD3eTBIzfJAbiMTcfszns0fYLAOhiTATxcBLQYE+7z1sr2O5W1XNXuxxWhXwRvTlBZysegMWpMln6kMCFWnKa3ZqHfyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Date: Tue, 7 Mar 2023 08:17:03 +0100
From: Jiri Pirko <jiri@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
	hang.yuan@intel.com, virtio@lists.oasis-open.org,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <ZAbk763tfCRpRIBV@nanopsycho>
References: <cover.1677761896.git.mst@redhat.com>
 <ZAYXZPVulKWDIuRr@nanopsycho>
 <20230306174654-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306174654-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: FR2P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::8) To MN0PR12MB5979.namprd12.prod.outlook.com
 (2603:10b6:208:37e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5979:EE_|IA1PR12MB6578:EE_
X-MS-Office365-Filtering-Correlation-Id: 8776b145-a9c7-4902-7b0c-08db1edbf5a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BfOttNmf9Gq6LpoIdC8cLR9kwy3/Cc/Mj4Cte6iIFmK5kXTGKwSYV/pq/EQ1Do2YkqCZqja5p71bt0bnMtdofNtL0Da/gnSf4GoikkNxezHZKLU8+BPkP6fAo+/mXjh7RCwiCuo5eTnN9Jo61FZzVQvnalOo8jCUHQKLS7jT0Nj/KLgvqKFNKQfOxqSTeFEftcQhtBq5vPZzsLfwdmYV1XZWN2yitC188aKsBZpJFSxw9FoSSLvQy0bzOyP2eZyfXhH+8jEEOp/iKwPkdf4XabP83jfdDmCWtSFqU5z6DKoNeBglT56wsLaBiHNYmp13Ejszz7FgUI2kKGrAMDbRFrafq1gx9xnqvhtYlO194vNDOFyFzlBBfs75op9xL6hnRRlrDzNZFaFB/aENaL3S8B9UqVDHhqz7muY7G0K1XVufjd+gPCfRR5bo3LiY1C+OHdwrgMi8473DwKILqDzglxTFTRA8B1Fnt5AqAC+ey5VCctVeqRFJFUkiv6aGT05b6HyCfUjzL7zUbSFRaSKdxQVfQyykZqVe5pKW8u/UnvAtvoBlHkqTl6ppjcMt85qj5HRWqH8MMfUEuFc6qqZwJTPkClIzG+yaylpmXOYvsk8ZMJnq85uFCG5n0ltafs1eih3Y/sDggRhjhRGxAmrBpQmK89CKwUoMvV0qdxRhZeav+ZTtmWWnneaM1zhPba2dYOqYZRa3MnwB0rnEpk67vUHYdV5uT4oI+DZg8nU3/+s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5979.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(366004)(396003)(39860400002)(376002)(136003)(346002)(451199018)(2906002)(66899018)(7416002)(38100700002)(86362001)(33716001)(966005)(6506007)(6486002)(186003)(478600001)(9686003)(6512007)(66476007)(66946007)(4326008)(6916009)(8676002)(83380400001)(54906003)(107886003)(6666004)(26005)(8936002)(66556008)(316002)(41300700001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bvsZfvEqYcIDONZrrmOwWFOKD7pVXt8aMO47zhtBS6Gkf2U1hS+G6RC21cNS?=
 =?us-ascii?Q?IZmGwkAyfLPavfSZbUjftEJncTwWI1/Smqlph4gi9xgPuXj17H1+RqZr98KC?=
 =?us-ascii?Q?dQOw0BgX4ee6YB7yAFS1Cjh7v3ik36hlz5RSyQmoppxpxDKlnTl5ZfO9SVAf?=
 =?us-ascii?Q?sbIWSv47bL8+89w3RZb0f3516fEpmKBE8ynDtBHOzwmtujTbQfV+ep/iluyu?=
 =?us-ascii?Q?aFjhsaoPuMwf+bKTZrPsJ64uz0j7gFcFCTykt8MfBo90i4GNVOCWAnG7xCZ8?=
 =?us-ascii?Q?h55MaliCoyHo84UvZpeEHoplBmeVGlx3mz8POvgiWv8EgPbmsKjYZTGfXhmM?=
 =?us-ascii?Q?JIGK9jOo6zcDZfwAPUwttwPsXytkgjxZq/HUhkyz3mcAKWamXPpjnOyljKCh?=
 =?us-ascii?Q?Wy/b9ui34G4PaZq4kIAE22+NwskOVMjgNB22DtH3lIn+jNJ6htYBMep1qBOm?=
 =?us-ascii?Q?zUg7MrWdUXzSgslfw3O6gMqrgmCMq4IhqFeZOgqRXSjPtHyAEcfD9/P/SxHM?=
 =?us-ascii?Q?KvQ227kCIWkDitnfJYh9DueN/oLgw5b+amegqdFMdOym6Vnv3g0xfXaKwcRF?=
 =?us-ascii?Q?AYv0vnnEaYQ5lme33utb8ih1Y4i+6PZSmw/UyCAPVzytatv0OFlbuAnVuR4i?=
 =?us-ascii?Q?RLAf1yQJZg4IsNy+6Sei5bYb6X//tdkvnjSEssLJt4ulSWsGgS5zmm8RG5EZ?=
 =?us-ascii?Q?xv2vyV8cLmoDeztryXAc3IrVLgU2G8tM9wtSRiS4zV/3wysyUG1RILu5L0gz?=
 =?us-ascii?Q?sQRBAGVOOuDXxdo4qiAj8CX8jWjDhhjgxF6EzpDngqzxtIw1E/I5Opym4xMF?=
 =?us-ascii?Q?3zhnhMBOew5NSp0F1WQxm0naMytwyrHM0jOuumic4Vzfj+9YN5vX7aluPy3q?=
 =?us-ascii?Q?3tkAxTNZwaX//aRfkCuBFCRv26ZZA4y2jU+oRSsAiEIzfeauGg+AxopVhvE/?=
 =?us-ascii?Q?lzP7xeGbtK6UPfuFzXD+sp9khOgLR+8ZfhlMeLILyqCT8yDgOd+UCT4gT3di?=
 =?us-ascii?Q?87hwt+F2ZV814AxvFkw9WZkiMMwvmPUlC5GrP1y5/C33F4ePUR+cjHaN5ueu?=
 =?us-ascii?Q?DDugSvZq5rpN7XmfhzfdwqaUMb2BxUjxN6TYFrnjUsc/S38Yt2v0WuytQaAd?=
 =?us-ascii?Q?aXKUX5A8j1riXJMATeRqvswZyhqphwfavPgS8RAUi4iXN+UAblHtY+V1+8Vr?=
 =?us-ascii?Q?JeM89odOsqgJJtkO6FXFGAEK+6TNnxrG/ChTTgSSO2dM3I1YkRQYxogLlsTq?=
 =?us-ascii?Q?bkFHGsXE0RCNpODSJBLqELrNoTJT8pc73X14J4vc0KmrCVCPFJmRuFs5/ISI?=
 =?us-ascii?Q?tURvDT/YJDQQoZlJMJbwB7qiXVOBNl+tkmqNQcKR4Xjh8Wra1YjfJzIroXPA?=
 =?us-ascii?Q?8PO7VZ+UGg3SqF+qp0l0Bvy1g2O458qVKaGk/E6rI3+FRJ93D97Z3x4tg1PH?=
 =?us-ascii?Q?pFaZ51FPBol+aCHZdU10pb33N7wSaRGJkTIrA6JOOWtDDSjqp8WzDyKSMreK?=
 =?us-ascii?Q?ot/QY/agiBqqEYnPhIsWYBR1r4UiWmrlA8z7IjewYD13pA5oYY9RWW6gauPW?=
 =?us-ascii?Q?ymnQ6mupSDu01ldsBrmPSV+tmiIWJBw+26ki/oXq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8776b145-a9c7-4902-7b0c-08db1edbf5a8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5979.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 07:17:07.3843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ddUbO+2umirPYV3QnH//zgwNHTGHBI56P4gsCQA73wTr/raYWmPJsQD9V6lYqEL7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6578
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v10 00/10] Introduce device group and
 device management

Mon, Mar 06, 2023 at 11:48:32PM CET, mst@redhat.com wrote:
>On Mon, Mar 06, 2023 at 05:40:04PM +0100, Jiri Pirko wrote:
>> Thu, Mar 02, 2023 at 02:04:48PM CET, mst@redhat.com wrote:
>> 
>> [...]
>> 
>> 
>> >  admin: introduce device group and related concepts
>> >  admin: introduce group administration commands
>> >  admin: introduce virtio admin virtqueues
>> 
>> The ordering seems a bit odd to me. I think that at the beginning, the
>> admin virtqueue should be introduced with generic concepts (including
>> the generic command structure), only after that the section introducing
>> device group stuff and related commands.
>
>That's intentional.
>
>Jason is working on additional ways to pass commands to
>devices, using memory mapped registers.
>
>Thus admin commands stand by themselves, and the queue is
>just a way to issue them.

Okay, in that case, woudnlt it make sense if the generic CMD text
(including the generic command structure) would go first, then the
"group" related cmds?


>
>
>
>> This publicly archived list offers a means to provide input to the
>> OASIS Virtual I/O Device (VIRTIO) TC.
>> 
>> In order to verify user consent to the Feedback License terms and
>> to minimize spam in the list archive, subscription is required
>> before posting.
>> 
>> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
>> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
>> List help: virtio-comment-help@lists.oasis-open.org
>> List archive: https://lists.oasis-open.org/archives/virtio-comment/
>> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
>> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
>> Committee: https://www.oasis-open.org/committees/virtio/
>> Join OASIS: https://www.oasis-open.org/join/
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

