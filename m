Return-Path: <virtio-dev-return-11515-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FDCC678D5
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 12:09:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 586E63359A
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 12:09:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4E0E39866F6
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 12:09:12 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 413919866ED; Wed,  8 Mar 2023 12:09:12 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 242369866EE;
	Wed,  8 Mar 2023 12:08:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CcDuR/XJt9KaI5ZeGDzFOpehY3ebL1okTmczT7fCoHsVDuOC1MaXSpxP61qOvemiFNcCg5fz+17v9P2h1eh3zEBUmggEwYjg9H9PBpEhz4R56cJKBMD6EdPnTy21icJVlWYtJ+ybb2s7dvanClGT3xQq8gEWeQoXaQXTemSkgb0DM+YTbNopXXWDpdSA+eSildeaxA8zl3m8tSUMDor9i8iBJQBtJlgigkKcLtmyVGZA+5zYsDaZs7XYykUTup8xN6QczOAEnHV8OWkucUHd1Wvb5NqHKhAzKSiCydnsBpaPuZdYSlYGYc9JmcnI3mYEo60FbqkvfjH36Sai3sbtSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cx1+5o9klQd6CxaEiMFyGfHPHdbtEqhe3OZ4roc2SY=;
 b=mbqJBlWvTTKfZnyM3VC+XZkKmCy8DT34uhbs3zT0t2G5VaB+V4hLN2mij+UhNb25t39fv0yvu8denonc/JGmF9It/v5t9ohqUt20Jh98+9zrh1aJj4djHU+N8JIKeZilckZGA5crz7XSONjLNtjWUqeV7K9dpTuC6zqUlTKtv/RggTYQ/DBP4hLtzmU01L3RbglA3nby/LyeD+dajtSl18zaseqlqRBqe//oG1c6hjggVd81hbCie1nTcWMdRHN673MMcKwATRasYVbGcHZlaFlEHbUbQ9XQNA5nFWLgaDvr3QVMNfAiU/KUgQPMGX9cXZbxkjNt+d8eR+SSNp65uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Date: Wed, 8 Mar 2023 13:08:52 +0100
From: Jiri Pirko <jiri@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
	hang.yuan@intel.com, virtio@lists.oasis-open.org,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <ZAh61E/wQ/hSY/OI@nanopsycho>
References: <cover.1677761896.git.mst@redhat.com>
 <20c81b66f0b21b5bd646c24840ac3f8462c86acf.1677761896.git.mst@redhat.com>
 <ZAXfegxCfvfLwiJT@nanopsycho>
 <20230306133816-mutt-send-email-mst@kernel.org>
 <ZAbpiRVdo8BciELX@nanopsycho>
 <20230307111458-mutt-send-email-mst@kernel.org>
 <ZAhdzCd6qwWydesz@nanopsycho>
 <20230308064505-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308064505-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::23) To MN0PR12MB5979.namprd12.prod.outlook.com
 (2603:10b6:208:37e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5979:EE_|PH8PR12MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a0f6294-73f9-45ff-91ab-08db1fcde3bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0RhBSTaf5vHynHc9vHN56ToFkLIL+Ci3E1EBb67+bG8oWWlPPlmYo0KXLiLRyFj4+WM+OoFz+qxxALBC39XwDOzsOcTOPIKZ42jMTjwQA75uvAS+4vRsCjaI5p5R+sqiv6wtBkdOIlJLFTPKjfGe1bx3Pob2qugUH54yCP+2Jw0IwoG5g7Me6tchNC1joJAIMAqkhrdnxrf4N1xYqs5mIV75Kp5wFNXB4jkQ7uU+1CYUrVE7ooYF/JX4/TmR/dXyKMbpP69ir7S6lRSj23ADPTirLKGImJWA7iGcQJQ0ScJOhTCeiq0aFpUL8vizQCq5hMPd5maG8l9rShZgaSQk8IKX0FBtMzPlgOnwUmBxZ96EALT/Ys1mmdlsk3afzR8wpG4tkrVx+arxx0WCArT22YEM81warA3xRWRfBTReshH3Wk349XobSD9xExqFG592doyIE8i8M4SNovFqAzVRwp555chPAPCneZgtwHIM+3SZfv6X3vP/Lwxyn3ZHdIik58zWp5a+QJ2cYB71+ik5ZzU+oocsSqi1RlzMHii0J1L5uG/f4+6opxWsDW6NZq3F7cYuaBt/RLGVEztcwXB4qTc/7j5vLaihVuosafxMSjOUcQSo0aFNhVW0W3JYy8d43tbtZINr4GMIR19g9Kh7kUgHBqPV5XQbtqgvqlXGIoFoElKPg216W4kW9wxgaPrdZf9E7QyYbuRxWXuS6DxablqYhYRf6S9zsgWa2IR/8Pw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5979.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(451199018)(7416002)(5660300002)(8936002)(41300700001)(86362001)(33716001)(2906002)(6506007)(38100700002)(478600001)(6512007)(107886003)(966005)(6486002)(6666004)(6916009)(83380400001)(4326008)(8676002)(66946007)(186003)(26005)(66556008)(9686003)(66476007)(54906003)(316002)(66899018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T7BYnX/70JngCQCjkxF9KMIcqzoIggzJAb7NY/2AjzKZXNW4GwQMFwwyKbWX?=
 =?us-ascii?Q?XDd9JGAfYSWetjxVpIl1Jggr/xdtmpp0/Dv8yOMb/t0MeP890wIMCAtLIPpU?=
 =?us-ascii?Q?4nvo6olyJgMcL3072M4P6r2L2Ev3lQHOxLc2uPUTeq0gUmd15f4UbEFqKZ71?=
 =?us-ascii?Q?nkTp5mqs1YywY2LpV4s0lAvWGVOvb19+c+T7IYCBsCE+H7Y7OKtGgWua8xnR?=
 =?us-ascii?Q?PxpA/0EFG3800EkrJvp4RB5klBxFLumFC1TWuHlCC1nytLdz2bY+qOdtZ4Of?=
 =?us-ascii?Q?eqONlaq659uE09wKwpO3CTd8L2lfRcTZmBF/vBsZ+zguYHO6j2eLEU+H3qcI?=
 =?us-ascii?Q?/7yuVkLF120Fy8cY/PQtiCdd2R1ElCxVZYX03OQpc1KzIx9vhpuBfuymKkPr?=
 =?us-ascii?Q?CfQPgMR1MABdWou3DotAOz94FdkZR2IYo6PYWfPJmxFY73gr1KHTItPU1ppE?=
 =?us-ascii?Q?iaTdSU9Bnuf+pqmKy86STpUJx7J26zmJ0rPr2Igwj0tBzQZsyKOqhkWRF/HT?=
 =?us-ascii?Q?e7bk6Wihg+F6sU3RVfRfnHOJtvAlDg4HNu68hShBFhxeyaPBSnCBEritbaya?=
 =?us-ascii?Q?gaSW/L+m91xcNSlZ37vjh0CHIsLWDeDsSc0Of0O19ApUU6D+JB1oMVy/omAA?=
 =?us-ascii?Q?rcwGm6OrPWcvOdGTwHC9heaUkvvEBVkjC93ibiqknSIl3q9Urr1LkgQXmAk4?=
 =?us-ascii?Q?/fAHVqizwQy0Ph9mFd/+tWK8UY0sRWvzfNmokw2cpXeRusJMYz3ZBcEP4mf4?=
 =?us-ascii?Q?U1QN9tP+2ucgOX7iK/my8u3mm8g+I7vFSXvgfc3KLpvjMy010MD0M9Y3PRZh?=
 =?us-ascii?Q?bYm+ijcvUniAN1mLr4iYJwmzahQYOKeAP6ZhIIdl2kQeRNkFirYUoEYn1stz?=
 =?us-ascii?Q?G7LqFGQKW9Hy6Csm2K2uohsY4vg9G/wwQ3Nd1oA7/zfY+1E5dZt+jIwKg9Jt?=
 =?us-ascii?Q?S8cUZv2C9cdYdPNkHWK1wV12zUIV2Hh7TmUx1h7bXh+bz0KRYe+B2CjrMHt9?=
 =?us-ascii?Q?p9mwSKgad3okIKNmh4Ek6iYagkWQegRNQqZJPRSnIIBd24pTVizmggIrNabc?=
 =?us-ascii?Q?4upOensPqWjb3El0qsgxJYsboPTGZnAlVJ2RrsKP4Ypj8BWqvTPjeXmUjXmi?=
 =?us-ascii?Q?9gia3Y83SN2GxiwNpMleBY0yOYWsU+EdEO1+x0d+i+eaqaVF409L8OkJEJN1?=
 =?us-ascii?Q?vFmhMPcPynX2oQOAXMrus24Nf1Kbg3FuWCdEFpq0Q8XQlEuIVObTw9JQwSqv?=
 =?us-ascii?Q?sNFM/lPQqAs4xf8nI8O79fK2fIzTvovkrgyGBUz/3LoAMezWrNC0gKOKXgSI?=
 =?us-ascii?Q?MQCJeK3kmQKDPJh38w4ADwtz4ipJf3QKruYGciKbmhyeuhg+1yrvx9WmR9YN?=
 =?us-ascii?Q?qOYDEg4i7ZiLW7dPO3Qmjuxm6l8wVOZcddpCRp4XHt0BXROtwWdQDsAsOWSW?=
 =?us-ascii?Q?z22lQDR4TTRFT7N/P8AilPdegDqOA54Z7udR2HbWHrJksMwAzleF+p29Ncwe?=
 =?us-ascii?Q?WWwYjL3JQ68YjcPcfiWoBbDQMHcmBPNSjpE0kUYmLIMPCfXgKAN+rOG/ga7f?=
 =?us-ascii?Q?PhH//lPut4j933Stk4LYLzdL6YYQT8EFebyKVztg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0f6294-73f9-45ff-91ab-08db1fcde3bb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5979.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 12:08:55.3784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ErZuNI2CI5XbQov2lBd+k1466M5709BI1gmqJXlA2/EPhb8FGyXWOmNWKU6NXC9U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6844
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio] [PATCH v10 04/10] admin: introduce
 virtio admin virtqueues

Wed, Mar 08, 2023 at 12:50:48PM CET, mst@redhat.com wrote:
>On Wed, Mar 08, 2023 at 11:05:00AM +0100, Jiri Pirko wrote:
>> Tue, Mar 07, 2023 at 05:30:18PM CET, mst@redhat.com wrote:
>> >On Tue, Mar 07, 2023 at 08:36:41AM +0100, Jiri Pirko wrote:
>> >> Hmm, if not for now, the future exension would not be so simple, I fear.
>> >
>> >Without knowing what it is I can't say.
>> 
>> Yep, so basically you say, for other things if they appear,
>> let's introduce another queue type? If yes, sounds fair to me.
>
>Yes. For example I find it likely that live migration/failover support
>will require a queue where driver pre-adds buffers and then device
>supplies information as state changes.

I see. So there would be a queue called for example "child state virtqueue"
or something like that for the sole purpose of getting the state of VF?
Hmm, wouldn't it make more sense to have this done as a part of "group
administrarion queue"? I mean, there is already notion of addresing
child/VF here. So from my perspective, it is just another "group
administration" command.

We would have to prealloc buffers and use it for this purpose as
well. I mean, the cmd payload for other group commands
could be put in this buffers as well, making all group command
infrastructure consistent.

Something like:

opcode X
group_member_id 1
cmd_payload-> buffer A

opcode Y
group_member_id 1
cmd_payload-> buffer B

Basically this would replace command_specific_data/command_specific_result


>
>> 
>> >
>> >> 
>> >> >
>> >> >Passing commands to devices themselves is already covered in spec
>> >> >reasonably well though not in a generic way.
>> >> 
>> >> You mean using the control queue, correct?
>> >
>> >Depends on the device type. network devices have a control queue, yes.
>> >
>> >> >From one of the patch description of this patchset I understand that you
>> >> cannot use control queue for this because control queue is
>> >> device-specific, yet group control is device-agnostic.
>> >> 
>> >> My undestanding therefore was, that the admin queue you are introducing
>> >> serves as a generic carrier for device-agnostic commands, in parallel
>> >> for having control queue serving as a generic carrier of device-specific
>> >> commands. If this is not the case, I think it would be nice to describe
>> >> the exact monivation and scope of admin queue.
>> >
>> >Nope unfortunately.  This queue is just a carrier for admin commands.
>> >admin commands are commands that talk to one device about other
>> >devices. There's clearly no mechanism in the spec to do that,
>> >so we plug this hole.
>> 
>> Okay, in that case "admin" sounds a bit misleading as for me it
>> implicates that this is for "administration" of the device. Yet is is
>> for the administration of other devices (slaves).
>> 
>> Perhaps there could be different term used to clarify?
>> Group leader virtqueue?
>> Group owner virtqueue?
>> Group master virtqueue?
>
>I used group administration virtqueue in a couple of places,
>just inconsistently. Good enough?

Yep, sounds good. Thanks!


>
>
>> >
>> >
>> >
>> >> 
>> >> >
>> >> >What we lack is passing commands about one device to another device.
>> >> >E.g. control VFs through PFs.
>> >> 
>> >> Could you provide examples of such commands please?
>> >
>> >For example a common feature is to program a vlan and have device
>> >put a given VF inside this vlan.
>> 
>> I don't follow entirely. The way how the VF is connected to network
>> should be ouf of the scope of this interface. The eswitch manager should
>> take care. What you say sounds awfully like the "ip vf" legacy
>> interface, which should not be considered here I believe.
>> 
>> If PF would be the eswitch manager, there are other means to do network
>> programming, using eswitch port representors. But I don't think this is
>> the can of worms we want to open now. I don't think we have a usecase
>> for it currently. Am I wrong Parav?
>> 
>> 
>> 
>> >
>> >In a virtualization scenario host controls this vlan programming giving
>> >the network a measure of protection from VFs.  If a VF is passed through
>> >to a VM, IOMMU limits VFs to only access guest memory so host has to do
>> >this programming through a PF.
>> 
>> Understood. This really looks like "ip vf" legacy. I strongly believe
>> it should not be supported.
>> 
>> Any other commands you have in mind?
>> 
>> 
>> >
>> >
>> >
>> >> 
>> >> >This is what groups do.
>> >> >But if we see more uses we can always add them.
>> >> >
>> >> >
>> >> >I'd rather avoid being too generic though.
>> >> 
>> >> In that case, why not to avoid using generic terms and stay
>> >> "group-centric"? What I mean is:
>> >> "Administration Virtqueues" -> "Group Administration Virtqueues"
>> >> "struct virtio_admin_cmd" -> "struct virtio_group_admin_cmd"
>> >> 
>> >> Etc. Helps to avoid confusion.
>> >
>> >Sure, I tried to do that but missed some opportunities.
>> >Will address.
>> 
>> Cool.
>> 
>> 
>> >
>> >> 
>> >> >
>> >> >
>> >> >
>> >> >
>> >> >> 
>> >> >> >+than one administration virtqueue.
>> >> 
>> >> 
>> >> [...]
>> >> 
>> >
>> >
>> >This publicly archived list offers a means to provide input to the
>> >OASIS Virtual I/O Device (VIRTIO) TC.
>> >
>> >In order to verify user consent to the Feedback License terms and
>> >to minimize spam in the list archive, subscription is required
>> >before posting.
>> >
>> >Subscribe: virtio-comment-subscribe@lists.oasis-open.org
>> >Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
>> >List help: virtio-comment-help@lists.oasis-open.org
>> >List archive: https://lists.oasis-open.org/archives/virtio-comment/
>> >Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
>> >List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
>> >Committee: https://www.oasis-open.org/committees/virtio/
>> >Join OASIS: https://www.oasis-open.org/join/
>> >
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

