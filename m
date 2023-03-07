Return-Path: <virtio-dev-return-11467-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF23FC678D5
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 07:36:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 348DA2A8E3
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 07:36:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 300A59866ED
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 07:36:53 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 242A39866C4; Tue,  7 Mar 2023 07:36:53 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 119889866C2;
	Tue,  7 Mar 2023 07:36:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQVqienSvu5bSjUg8Q032fIw91mW9a0+unWzqjEL8QdTBnyBp/ci5zRrTdAfpfdtfE0MQT/QCTYRGNDZaLg93l02iRcwjIPyG1kS7CB/lHug41/3M4vhFQNL+plfOO+9wapa99JyJOWjHkLJLm+cxXzEE9lVCMpChKoaOJmAbu3HK6s+71Tu9I8Kc/nHSh7h2F54CfsxJwJxe0gqROBNziMc+pdrpYJKXkrTOvLVLUKL7hLjRmJmj/Qob8wxJigdfQsEU9opKNwjTwMpplvnXFoCPTMl7Jqz1mc0KvwMKQxmt26L6/LFOB5INv4qGQPZmMVi69cN1xJHGYcaDQ0pIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsVxLpTbKzMimvOg2Bvm9baBUYDkQxPw1LqmT5cFXOU=;
 b=LVrQrnYsioXPQJlOHLCkHMdhPK6dIhSOJ6YKb/ZX9f6JeVynDzJdt86ouPyu+SPdOFepiMwHXBRmeQjD9aCCaCxeQ+1d1hCL6zFBl02o93YSwdLnnVkR2uLAdcDCjfS8FRG9FabMcClklcDTeetQoF8TwbesNubHKbqnPTu9R30Fjv80ZMyOkp6W3KNF3gNKfgY5TERN9Uc2Z9Gy1U4XdBFeQmeFQnFL6CCKI4APJU61D6NEvLh53ETf0pnyCjkphZSVtEEyHH1kItqWhet9xlWMDgR4z/XnZpgkE+Zoo5Sf3CytUcIaiHdeIXJ95MZUF9219Zw1RV4D+VK/AKSfbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Date: Tue, 7 Mar 2023 08:36:41 +0100
From: Jiri Pirko <jiri@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
	hang.yuan@intel.com, virtio@lists.oasis-open.org,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <ZAbpiRVdo8BciELX@nanopsycho>
References: <cover.1677761896.git.mst@redhat.com>
 <20c81b66f0b21b5bd646c24840ac3f8462c86acf.1677761896.git.mst@redhat.com>
 <ZAXfegxCfvfLwiJT@nanopsycho>
 <20230306133816-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306133816-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: ZR0P278CA0125.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::22) To MN0PR12MB5979.namprd12.prod.outlook.com
 (2603:10b6:208:37e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5979:EE_|PH8PR12MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: 27164862-4179-4cb7-bd52-08db1edeb429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7Lj+eAg8kLcIuCJV1386Gruv5uPuasBuni9trduSDXkq3T2InORecTDavzeaG7WzpwKx3K+msEZzaW5j2WY1gh0BMtEXkrnYwlVc9eWbuqHPf0U5XlnARmOH1erg4TWylvReKthEUU0PMbM0eS2XMr2U/f0AomV/ERjmqRjL9tCT/ILhD44waCIqgjegPdTr2k4qgnu+5EL2KJTQuYykVlp/2/bysBmfAJMkl4Enw1xdZKGvwpwEOcu3VND0Hy+cWPqcjnfHBHJypRdsMfmtNcbZBJ7VKxZjwG1Op19YwR0u9l5xlsO20wFVmCAKrhP8NyOtm61YqJTsihivBVcheVwAeuKbk8Zn9/+2axDNJO1+E7vsGct8p1fNiyOEa9O57cn34zCaOl9wGVB2JI9xrQhjkbHSYqibWX1XGkAVs/GhQyclIxZREIef2etGTQvHmAPaLkYDzDi2iUCblK3ucmfJOrrkv5mZZZ/OogrzzZuk8onIzffnL6o1CpSBZLyurTk6A0/r8K3BxS3ZDcyiQKnRAP9kRUWPr/KbnjRfXdtEPJXys7JPwEjLIFnIA+O0FPTBTmMX18v81Z42hfmKcAfzvbwg3KRlilOBxJzx4j0Ch3dvHWIBKtHTZNb9QGoreiTysELmnzXjUof8CMrJ9A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5979.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(346002)(376002)(39860400002)(366004)(136003)(396003)(451199018)(86362001)(38100700002)(6666004)(107886003)(6506007)(5660300002)(2906002)(66946007)(4326008)(6916009)(8936002)(66476007)(7416002)(8676002)(41300700001)(66556008)(33716001)(186003)(9686003)(83380400001)(54906003)(6512007)(316002)(26005)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tHEP25KMh7fOUCF4mY7PcoZkkUshHc8K73jfI4azCmlloqxcdKdKKbjrdZtA?=
 =?us-ascii?Q?5bhrp9GPLMrx6iyAE6b4nzCqHJa9qUuCKqGpzbP6wxDtwzT05TC+LL5+aW9c?=
 =?us-ascii?Q?UMlUEoO9+ZCQ/APgT2IWKOUQSs0kbgtcwDXcdHrg634Yn+5Xj8cflGPLH6bD?=
 =?us-ascii?Q?WAFDwGyX6On7CAOSXawzcGah5oRP3SK2uQ8vngSFUF4GTI4hD4KDhhO95ca7?=
 =?us-ascii?Q?015y9xTCkshCa7kndiPqNoWhJkVRYjKEK/6ddbogLpqa76GkIKSTPiEaIQbg?=
 =?us-ascii?Q?IncbtFbK/pSxtmDV8juVHD4xDnHn07R2cXCmpqgQneaHAYX6ID5FjUL150F9?=
 =?us-ascii?Q?JPbNigZOzuE2vyzOOAo4WMvBza56spbj/7ZuD6Wzy5zj7WYky/ZK5w7hHzzD?=
 =?us-ascii?Q?UtWwvj7LNNpsqey7WQctXRibXaWOh69i06kLArev6QXnofOQcmTHUV5YgV8K?=
 =?us-ascii?Q?F1nWSaEqclwBgs+S1zoZIbCOra1WNrvakGf5TIJa0MgvUaBc5VzyqALOZauT?=
 =?us-ascii?Q?T6RuxO6kXuKJMCAOL6OVhXUgnXjO2OuvqciXTGIskL6qCRYxI9FiLJ8x2oFB?=
 =?us-ascii?Q?cgC5JMdHCHcFo5DpcMY3gs+E1/Mr29p+PNJU7JwU7zQwMI8Zk6CWo3ckTtuy?=
 =?us-ascii?Q?jS2qq2FnfqXP8bt1vvDlvGXOzDyp9SLWpbXtUiL5JIyBQgsodtGnlfPxW0V+?=
 =?us-ascii?Q?FIUaE3FW+KwXUX3oMWN7kSLSnP17UMx8ze5Jo2dZZ56c8QHVXc5ZL1atHOvL?=
 =?us-ascii?Q?yipPaAk5pZjjd91wEKy3OcQewQvtbLgfKMjb0K4FAbYLBbVFw+tGDwsdmkQJ?=
 =?us-ascii?Q?Cr84+dJeLuAsVxUj8dc9DVfO1GI9ZPrynGC22MZkvRtEsrgxbdlrM6b2d3Or?=
 =?us-ascii?Q?NthhFmMimgdNmz/HkAUkIY+EkOApIojSeo7Cke+470dMvS4sahsX3tXiOnPN?=
 =?us-ascii?Q?YWi61KJTOuP+Ma0n6sjhpcvch7WvdK/VM3uQFvgQ2nZvSFiduvzJi9vNtR5o?=
 =?us-ascii?Q?niv96j7RNcl0Fzfptl/zFw/eZ8mv7EHfrtqZP2pzxdIny+VCn3CiIOaggVf5?=
 =?us-ascii?Q?KZfFXWMAheX32NxZCnEiL/V84rh52NDW78Nb9V++J/mUN+/zJsfRU8VLNwgR?=
 =?us-ascii?Q?lheLHep+3zWp3QBXj1rTjeJgb7ryxw59HckUCBoPtLxrDRtCWMpz2AuOo1Ut?=
 =?us-ascii?Q?gXhx//FEPWFniMml7V+feKtlSPAn8aHpmXKwuKMAKotqkqSGzhsV3ryOgi3b?=
 =?us-ascii?Q?Ibtw4Tq41y4kEIA+Y7p46tCUFDM+mbGvohTH+sA525G9IY0BnlbGUfjDPw9X?=
 =?us-ascii?Q?2EWAIxojSebTrml1/7jhrp45cWbp6gCp0FtG0MtHcQts5Qjjonlxge0IzH1I?=
 =?us-ascii?Q?qkgLpuxfsAu56v1nGNrKQZi2YPm2M1Z9BGjRr41NSE3bCClFeVt8FIFnDN0e?=
 =?us-ascii?Q?LtYA/LfqcNqd3WI6K0c/VpHLbCGlgNL2Mz7XXD2ad8oKEYXqspFHyqYkibOX?=
 =?us-ascii?Q?I54iA9HmEqTLgPBriAfpJwmybABPHf17ZPRVPr2tg8wgTYMQylKGJnxZz+5x?=
 =?us-ascii?Q?k703XOHYccnUUNNAS0O3YddVNSqnYGZZWIdHhV66?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27164862-4179-4cb7-bd52-08db1edeb429
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5979.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 07:36:45.8826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dzmu7KGieIYVMnu7KSAUJzwSJpInFiKMvR4bownv2CbMwqBXmFDfEokfmmd2XJdL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6865
Subject: [virtio-dev] Re: [virtio] [PATCH v10 04/10] admin: introduce virtio admin
 virtqueues

Mon, Mar 06, 2023 at 07:40:38PM CET, mst@redhat.com wrote:
>On Mon, Mar 06, 2023 at 01:41:30PM +0100, Jiri Pirko wrote:
>> Thu, Mar 02, 2023 at 02:05:06PM CET, mst@redhat.com wrote:
>> >The admin virtqueues will be the first interface to issue admin commands.
>> >
>> >Currently virtio specification defines control virtqueue to manipulate
>> >features and configuration of the device it operates on. However,
>> >control virtqueue commands are device type specific, which makes it very
>> >difficult to extend for device agnostic commands.
>> >
>> >To support this requirement in a more generic way, this patch introduces
>> >a new admin virtqueue interface.
>> >
>> >We also support more than one admin virtqueue, for QoS and
>> >scalability requirements.
>> >
>> >Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>> >Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> >---
>> > admin.tex   | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>> > content.tex |  7 +++--
>> > 2 files changed, 79 insertions(+), 2 deletions(-)
>> >
>> >diff --git a/admin.tex b/admin.tex
>> >index 7e28b77..3ffac2e 100644
>> >--- a/admin.tex
>> >+++ b/admin.tex
>> >@@ -155,3 +155,77 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
>> > \field{command_specific_data} and \field{command_specific_result}
>> > depends on these structures and is described separately or is
>> > implicit in the structure description.
>> >+
>> >+\section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Administration Virtqueues}
>> >+
>> >+An administration virtqueue of an owner device is used to submit
>> >+group administration commands. An owner device can have more
>> 
>> I admit I'm confused. You introduce a concept of admin virtqueue, which
>> sounds quite generic to me, usable in future by much more things than
>> "device groups", correct?
>> 
>> If yes, here you say "group administration commands" which contradics
>> that idea. On multiple places the text this patchset introduces
>> this very muych tights to groups. Like in struct virtio_admin_cmd
>> which contains fields very specific to groups.
>> 
>> If no, isn't it a mistake as the admin queue should be here to
>> handle more than just group commands?
>
>For now, no.

Hmm, if not for now, the future exension would not be so simple, I fear.


>
>Passing commands to devices themselves is already covered in spec
>reasonably well though not in a generic way.

You mean using the control queue, correct?

From one of the patch description of this patchset I understand that you
cannot use control queue for this because control queue is
device-specific, yet group control is device-agnostic.

My undestanding therefore was, that the admin queue you are introducing
serves as a generic carrier for device-agnostic commands, in parallel
for having control queue serving as a generic carrier of device-specific
commands. If this is not the case, I think it would be nice to describe
the exact monivation and scope of admin queue.


>
>What we lack is passing commands about one device to another device.
>E.g. control VFs through PFs.

Could you provide examples of such commands please?


>This is what groups do.
>But if we see more uses we can always add them.
>
>
>I'd rather avoid being too generic though.

In that case, why not to avoid using generic terms and stay
"group-centric"? What I mean is:
"Administration Virtqueues" -> "Group Administration Virtqueues"
"struct virtio_admin_cmd" -> "struct virtio_group_admin_cmd"

Etc. Helps to avoid confusion.


>
>
>
>
>> 
>> >+than one administration virtqueue.


[...]



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

