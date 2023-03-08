Return-Path: <virtio-dev-return-11502-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA7B8C64EC4
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 10:05:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 092613E30A
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 10:05:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DE18A9866F2
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 10:05:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BC6EB9866E6; Wed,  8 Mar 2023 10:05:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A7C999866E7;
	Wed,  8 Mar 2023 10:05:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwIm/Dw5HMqRC7CyC3otMtNHbykAExdRHsvPRm9K3eY4OwP7nQ14CjAqTGkM+2asnbv/rJK+vR54ur8xJwQ8qFpt0Coi9r9QekbVCSXz7uLh2q31JjZiwnGx29lD6NNpNYaQC2svCi4X+IV0zk1n1QBdZMFqSxbJo+3F+6ZeUeEElEWN6qe4SXfuGZixSvDnO6q55VOJasgSCDBhLOAJ69yJwDOi+APLNOykssU8gJcckvShtDF2tWfI31Z2UwFl0vXzsYZi3c3uLb/TKhu4PAtUGhW4WKr9ztobbtotd6Cl2qqP2MkfwX725V1O56XJQXhY5lGaAwN/anFWg0nXlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtC77kGrt82CC0FO3GPHP+ZSwbgBhgJsGIxmKQyGNo4=;
 b=SRiBqX4hLxYAfQgThlrpnbsX5jcdZUG/L7741Xm3DYgO5hFTX2TKswnV+PgsLBflvcOCyg8+qcZ9d8z9l+GDLWct1j9ZaZoeZIcvg9heZnyRu5jXt6eZBQAdeR3xGPr+ZqlvdT49/08gCU0eUJcZ1sNES1/CqFgNUA4teo4JLWf41mCsm4wLm6I8RzPCiFcje4UGe3DqGXjCZgfefP06lEp2FOyUN7jofq6kZx5R7wVi+rcgIV5g9M415iHMJZVY8CooJbHYYyZi+8h1l4IdfO9DnstMRxCyr7MyMqqSfgKGo2++JMBg0s9hos8w9KJFmCtZNlL4glWRer6HxRZw/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Date: Wed, 8 Mar 2023 11:05:00 +0100
From: Jiri Pirko <jiri@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
	hang.yuan@intel.com, virtio@lists.oasis-open.org,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <ZAhdzCd6qwWydesz@nanopsycho>
References: <cover.1677761896.git.mst@redhat.com>
 <20c81b66f0b21b5bd646c24840ac3f8462c86acf.1677761896.git.mst@redhat.com>
 <ZAXfegxCfvfLwiJT@nanopsycho>
 <20230306133816-mutt-send-email-mst@kernel.org>
 <ZAbpiRVdo8BciELX@nanopsycho>
 <20230307111458-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307111458-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: FR3P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::19) To MN0PR12MB5979.namprd12.prod.outlook.com
 (2603:10b6:208:37e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5979:EE_|DS0PR12MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: 37a73fde-71f4-406a-a7a2-08db1fbc9719
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	x72QVqKB/CrqNXCxMgIALGgzlFwc3BgAUaPX7m0yBeftR9HclYEFkpTLiDSltzK1SOzPuqSix6dlHUyXgrfcP402EkQg+GzOEgxKR7Wb+vTpRD4wtE4X+fov7WfhUm6yB0b+rQkm19TqyMB0HumhBc0xcctSe4flVp6g0128+omHJaELkpJ+vIZDtUYOWdxLYlFqwKZS5ZiB4yxoFeTeNZORw5fgVSTrrZWQx7RFUoDv1h0hKP1tnasp31PtEucyzMp0SCd6PqnhdL2XL6VQe+4CnA4luGNTOzcG1YikderTF/RJC88COijN+1VeJVtkUr/xcIbeOY3K/ILhglqpQkdzhpPpfHzVqtlVUVCRCqD+C8G93iX3oNStTpBEvsB667iuhSUMf4iWY+6bY9ZEUexyKR0ALXMlj/hBC1wqh8cvjuCMH1ItmEBAh4JMGs/D7xgJuZlDzlEu7ZwP6HulfQECQ8uoEUcM5SDhNMW7QIP0aJi/z7C/L1u2RRPj8kx59zqVxW8/eC6+NAuDBUX9PdNRU+kGqeKCMGyJFj7RQKrzqovP8QdMJ7v33BztabeizccjCQlpkog8wW/HRmp9DYUIBrWjzquQD1DeaygrKq1K6CrI/qMsIRwXFeLd+BUTpZKXuT1fCN3PTyUvE94AvCmgSUfPqgLSZ9rAqW/jnXDu43rqKaFhjzM5pMVZN8/6wYjquOxJzyE5abY6STRszkgs5GY9xCJtaJpwku8HRj8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5979.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199018)(478600001)(9686003)(7416002)(26005)(83380400001)(186003)(107886003)(6666004)(6506007)(86362001)(6512007)(2906002)(966005)(6486002)(5660300002)(38100700002)(6916009)(41300700001)(4326008)(66476007)(66946007)(8676002)(66556008)(316002)(33716001)(66899018)(54906003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EwtiwU3pKifC4J1iC99dzT6/wdTmuEzWqQ0HXURKt0K6p6+Q1cN5qF6bZbYT?=
 =?us-ascii?Q?sUt+SaSasK7Fd70a7RC512jXa8XZqxk+1yDXSQelcmTLHc3N6/fw7RXLWsk3?=
 =?us-ascii?Q?GobvAaozvJ910tl6cStbwxn8Vv5gZBpmt1HiIpnbFTpH/JtI8652lLhoLo/s?=
 =?us-ascii?Q?JDYDDZ5SBEmdEUR09NXHGv6UZ2uJivH+wrSji9poaOtY2h7BqgdqMvw4AeDS?=
 =?us-ascii?Q?oJUjRApfdAwoyD3MxqW/ouyQTD1NrFH3fmu8jiZ5qLi8tI/ArCezkYNM2SXb?=
 =?us-ascii?Q?3pClQ9hpOkGts8pvTAnv2i5VP9oFutvu/qnCL3LU79/LsAbr9r9K5BlQyvsK?=
 =?us-ascii?Q?0FQfLGp9/yfRcIaVZC0J+cF3eVj8kksv7BmJPC8KLslUJvxR25nt0Q6VKk/4?=
 =?us-ascii?Q?Iarhza9bmoXmY9Cv1574Q9JPPEcRes3Kl25i8RgVH0Rzk0pNiIrHgFuvVD6c?=
 =?us-ascii?Q?oW36iAUw/3aOiYOhgC7MJb33fzQBWDmrGMd8IiQaS3NP45ylzZMF75ZuiCR5?=
 =?us-ascii?Q?qjXd8GRzrQ+LyKmoANhC3yIwTumSx0D2a3OTwk0DvIWmC9UYVWHJmbHVRxQe?=
 =?us-ascii?Q?jbVVOrQ+FIhzwoOBEHfFIS6nt57p33jOq6iYlF9Qdf3FjaVyc8duh4TPI6D/?=
 =?us-ascii?Q?rOTA/m8HA0VbhMSeRnSAMnxcleOQ3NOC3+1bD5RLrwoLLkuzDUN+tkNB9OQr?=
 =?us-ascii?Q?BfqbOkRPFlQNmt++2OtrJDgb7aaZszQdsT4MjeMnETc5dmVd21ipN2Wgixw0?=
 =?us-ascii?Q?dqInWSWE4KYevR5frDrSq+Lm6JfVBHeDUleKGMh3PCk2PKKee2xiTgEgW2FZ?=
 =?us-ascii?Q?fq0IEIhc9wIKpvLV9ohVXxuxH+St6OwE+Ri5/LSLBf3Cgg0BbOGGBdk4LAiA?=
 =?us-ascii?Q?NY3BcSkLsGlefqLPQrmXypxt14uPIq7kTyVCx7vXrUkoNr3ioFCdJ1W8FYXG?=
 =?us-ascii?Q?be81bm0FZrPU62oqJ2HHX/CFih5uQDHUVcJBfk7nzxvlDNdn8qQI31GCe+RL?=
 =?us-ascii?Q?3DEET9TH0C4GzT196tbZeSsaK+sfd1LL7Tz/9ZXdyLiO8/Q6PM3B3lELi+SH?=
 =?us-ascii?Q?L6zjgDPtF5fw3Z7ExYLxQeY+E8wQQtY2VEmNZHaG7ayWAHD/9FSE5O+DnlbJ?=
 =?us-ascii?Q?AVZGypht7fDyH/frb2bOIV2RB2uqjTAqUZDqK1LYWviiZrtNw18gF3vtusk7?=
 =?us-ascii?Q?5EGByu71z27Bd12lMsxxSdCIvFRVP7GdW8SbvzDuTbGl0HUOH1pMzaJ36uTO?=
 =?us-ascii?Q?1q5bEfUjvDKM5ANfXZLDfOIvu8Qa6Flof32UihU4ZYKbNAPcV06QaY+4HFzq?=
 =?us-ascii?Q?2W4LXCWmEV+EbTvWaVpJBjJ6P/WmqiCo2z729/njGeOx+baKPd6TMVFEH/+3?=
 =?us-ascii?Q?+eFkmAucttvZMeCu8K/E+CNUqe1CfrkioyAmTG1k1HQZrEvT0nsSffOYLuLm?=
 =?us-ascii?Q?gIUDo+zRq4RehaDDsJv6TllRTDlSeBaWHk5d/ulvTWSW5FZEcjZu/FkLkxes?=
 =?us-ascii?Q?V8pAkxKsRaNgQcbbUl1BvoTt0JDOsD1pFgUk85e2BK8c/lN+3gjn/AIG8/Yr?=
 =?us-ascii?Q?gXnlWmzJ3LhQRigoL2wB13LargRX7ZSaiW1ahM5N?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a73fde-71f4-406a-a7a2-08db1fbc9719
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5979.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 10:05:05.4441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4iBwJCGgOfLhBcmvzBOTt+QQHrCyp3qelGLSxJxGjnAql618mZfxWRTyFUbHWgTm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7928
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio] [PATCH v10 04/10] admin: introduce
 virtio admin virtqueues

Tue, Mar 07, 2023 at 05:30:18PM CET, mst@redhat.com wrote:
>On Tue, Mar 07, 2023 at 08:36:41AM +0100, Jiri Pirko wrote:
>> Hmm, if not for now, the future exension would not be so simple, I fear.
>
>Without knowing what it is I can't say.

Yep, so basically you say, for other things if they appear,
let's introduce another queue type? If yes, sounds fair to me.


>
>> 
>> >
>> >Passing commands to devices themselves is already covered in spec
>> >reasonably well though not in a generic way.
>> 
>> You mean using the control queue, correct?
>
>Depends on the device type. network devices have a control queue, yes.
>
>> >From one of the patch description of this patchset I understand that you
>> cannot use control queue for this because control queue is
>> device-specific, yet group control is device-agnostic.
>> 
>> My undestanding therefore was, that the admin queue you are introducing
>> serves as a generic carrier for device-agnostic commands, in parallel
>> for having control queue serving as a generic carrier of device-specific
>> commands. If this is not the case, I think it would be nice to describe
>> the exact monivation and scope of admin queue.
>
>Nope unfortunately.  This queue is just a carrier for admin commands.
>admin commands are commands that talk to one device about other
>devices. There's clearly no mechanism in the spec to do that,
>so we plug this hole.

Okay, in that case "admin" sounds a bit misleading as for me it
implicates that this is for "administration" of the device. Yet is is
for the administration of other devices (slaves).

Perhaps there could be different term used to clarify?
Group leader virtqueue?
Group owner virtqueue?
Group master virtqueue?

>
>
>
>> 
>> >
>> >What we lack is passing commands about one device to another device.
>> >E.g. control VFs through PFs.
>> 
>> Could you provide examples of such commands please?
>
>For example a common feature is to program a vlan and have device
>put a given VF inside this vlan.

I don't follow entirely. The way how the VF is connected to network
should be ouf of the scope of this interface. The eswitch manager should
take care. What you say sounds awfully like the "ip vf" legacy
interface, which should not be considered here I believe.

If PF would be the eswitch manager, there are other means to do network
programming, using eswitch port representors. But I don't think this is
the can of worms we want to open now. I don't think we have a usecase
for it currently. Am I wrong Parav?



>
>In a virtualization scenario host controls this vlan programming giving
>the network a measure of protection from VFs.  If a VF is passed through
>to a VM, IOMMU limits VFs to only access guest memory so host has to do
>this programming through a PF.

Understood. This really looks like "ip vf" legacy. I strongly believe
it should not be supported.

Any other commands you have in mind?


>
>
>
>> 
>> >This is what groups do.
>> >But if we see more uses we can always add them.
>> >
>> >
>> >I'd rather avoid being too generic though.
>> 
>> In that case, why not to avoid using generic terms and stay
>> "group-centric"? What I mean is:
>> "Administration Virtqueues" -> "Group Administration Virtqueues"
>> "struct virtio_admin_cmd" -> "struct virtio_group_admin_cmd"
>> 
>> Etc. Helps to avoid confusion.
>
>Sure, I tried to do that but missed some opportunities.
>Will address.

Cool.


>
>> 
>> >
>> >
>> >
>> >
>> >> 
>> >> >+than one administration virtqueue.
>> 
>> 
>> [...]
>> 
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

