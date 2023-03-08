Return-Path: <virtio-dev-return-11524-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E3AC64EC4
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 14:02:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A73512CADC
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 14:02:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 908D198670E
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 14:02:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 837D99866FC; Wed,  8 Mar 2023 14:02:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6D7369866EF;
	Wed,  8 Mar 2023 14:02:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ffn14DKXtKhVomMpoRDYUKCXagIiZXK6YO4pXRO4ilGnvTcDPmGW87mkodEw8OU/WjjLWNqE1Oo992R1cuI0x5ucB6Ppx5rNlDM1bSp1jtkCaKqiJIv1BPjYLJPvdN0HGKSjGD9nGRnwggtMmrsKK9jwy8zxjCd3rcszfFU9VwaXeiGJjBGOmijX7b+R+yWUD8k8n9jfWEFIvmUe5s4DvrNITSitqW897BxGGzr16CKmhGNLEjynHCzrDS95vcTGXzAl3II5d3WlSPtubqJv+97GdRgRSDXDObUPPGLZGHcXoi+4pKLZZtA2uCv2DbpxNaMQEOpADaUW/AEBUCKbsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=riwYUDY4mMHXClMzKUVsgeUODwpgDdpRQxFTZ8y3ZV0=;
 b=N4d2NoCiaB7vGxmUjnX/5TkwFbcVHpI+RbxatnZpT2Z33VfOdebbp9jea2g1PvvykBdFJiimCnekRyykbVgSS21eANUjSCWndDCOUM6jT2imfgH7/J5m3k8znzrxGLfIRGmdVpdQ02LLQLh6Lrgt49V1G64prhBFqAUcYHEbCWvcAKJdPiYlAYAtco+8pdLGQKmkOBPYdhX3jiGFeoljJcnkqrJMYYWeFY7Ltq6Her0DN4Z1nI/Opq7J2H4JaL5j213S9H+vUYqdV6uzlaTqf/NClH97wxz5HP4mVKxXR02ZIL8wg4IyMyi104PUU2DH9whk5q4kL2tr/mp0eXFj+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Date: Wed, 8 Mar 2023 15:02:05 +0100
From: Jiri Pirko <jiri@nvidia.com>
To: David Edmondson <david.edmondson@oracle.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org, jasowang@redhat.com,
	cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com,
	nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com,
	virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <ZAiVXdawwbZ8CvXR@nanopsycho>
References: <cover.1677761896.git.mst@redhat.com>
 <6677477d48dfc234d3d1a339fb39d8fa2a3b983d.1677761896.git.mst@redhat.com>
 <m27cvszuta.fsf@oracle.com>
 <20230308065526-mutt-send-email-mst@kernel.org>
 <m24jqvz9ep.fsf@oracle.com>
 <ZAiH/d7igeVCt4WE@nanopsycho>
 <m21qlzz7br.fsf@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m21qlzz7br.fsf@oracle.com>
X-ClientProxiedBy: FR2P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::8) To MN0PR12MB5979.namprd12.prod.outlook.com
 (2603:10b6:208:37e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5979:EE_|PH7PR12MB6634:EE_
X-MS-Office365-Filtering-Correlation-Id: f0ddb460-09e7-4727-0a73-08db1fddb4e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	15ZN0XUIv6tXAR0iq+zkR1VP4Y/trSqHd5iDo+RoERP0U+iiL7t2p3mVOkGT8///FDk9bhpn6VpFhq96KZ6NN2XiEgqA9m065aYnHbZZzGBWv82m6TL2/9c6JLddteJYsCrmWm6pQYPia3U5C5lv1B4xnBduh3Jr3AEDW5sMI/UarUqc0ML7zvUOISMD2D0BsaiOwL9VTO1C9tLaR0IwNgjFn0z0HlYcSoaKbquGokNrfFhs/g88GaCa67rDYz7SnnFdeVi6RFy/oWHQLndYHchBewvIyHlbQr+N6V0D5ByNw5tCCO5exUUCmO7ckOR/GK/rLbDGX3zJiLr9nHy+56QOgWpbceC4ofHzvrZpJwVBnNILiOVJSCjy7UwhtbdVXR9E/n5cLdskYdDTXrXIj0Ydc7VXICUPfkaY4HwrfJ6LMnTfmqG74gzMOMZC3RIrhCQQxgchCeMG6+mjFB1JzfmChnvPtPZqHW0p9yCgVkPkGT+H73TgJF64sqyH/GGQa82IM+bWQYM0axQPZrLDDE1hW76cPemU8BS5rbnQTm1xtoLbvl3LMZp98z8GFlI69FUNb3ytzebBrwHQp/x9MOHB9sHKXDnw7lQBgvml8CfQjYSWWJL/iArDzNsKRnWG5nC1kfGnQ4TerQpFXGQekoAuuE+EiI8ig6QOtS63fOfxOFnvroMxVUVzcp4dJdAS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5979.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(366004)(136003)(396003)(346002)(376002)(39860400002)(451199018)(16799955002)(54906003)(7416002)(478600001)(6486002)(316002)(5660300002)(66946007)(2906002)(66476007)(8676002)(66556008)(4326008)(6916009)(8936002)(107886003)(41300700001)(38100700002)(86362001)(6666004)(9686003)(33716001)(186003)(6512007)(26005)(6506007)(83380400001)(66899018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tx972f6VP5CaG5q8vWVnbc1p72sNOGGzM5kVtJwy6VqNHjabsPWU/PoChu8t?=
 =?us-ascii?Q?oHYVcnn0dTRUGGuGhsTbjnKpxjKygRnH9PdS2803Yqgr7F/vnCsVCgMtpwzX?=
 =?us-ascii?Q?AzHlIm+Mjt1N2OYp6NcxNMLgqY8HsPEzerN4Vbq3nmv+PeLWU/+tNm6OStZP?=
 =?us-ascii?Q?RFtS1my7CWLm9oUwQJ5ayYEuL/KI7eRjPPjJZ0iC/Y2RtDzA98wpiXm7qLPn?=
 =?us-ascii?Q?HtJYXqdsSr09/F2cHtA8lm3HQEZnwxXo7j1UfiQAyx/jxJqDuEiffNhaid41?=
 =?us-ascii?Q?QPNHlJbV8fjy/HvvwEjxv04efI/CBBcXCHli09zhyRpOa56fg5HEScVbIDBy?=
 =?us-ascii?Q?3UjFl7AxeAJ6shk5COWkwQDGqMZtXsoDCgKsKusnXGBDgPd2A92Pqu++fDC9?=
 =?us-ascii?Q?RwjpYKWZJyQIcjjpbIF6DxPbD4M63mQkQnLvqWsMbC0fMYtY75pAZc372yvU?=
 =?us-ascii?Q?opQXcFo2QXP7r1KN5FL0aTsRsL4wjCS+8YGazE9XJmuLA0ellA+o3ZyNao6O?=
 =?us-ascii?Q?9GsI5J9Qj+Y/YaBD3y1dies76pgdnYsO73nDQK5yYjtk23JCwibEqh+iweBa?=
 =?us-ascii?Q?MMQxLOycwrclv4b+Ljn4gn8+yM9pbNiBRRTFmmnINF4/rg+qvYcCeSrO5sNs?=
 =?us-ascii?Q?ppaf1uIdz/mwst8AyiCsB2fqgWainsIe7u0wK1qEJfdsdju9CEEuRaHpEnhk?=
 =?us-ascii?Q?lF07R5wNpyUceT1YZUqDfH4nPdnTNv92So+xCl2wiH6Z1+6Pgofja5NIa10o?=
 =?us-ascii?Q?KFFsBWHNisr8HfRszvHB/QiJHdo/SFhwtRd0jpSvbMiVj6mNtoldxNmGJyZU?=
 =?us-ascii?Q?36+3E+rz7eSCDUBn/+f5fnEd0ga/yYLTrp+iSEWtBp4FrpUBZ5hR+zWp6lX7?=
 =?us-ascii?Q?oFv59441/olx71LG7KeCwMeqtiZea1hAs7TJLbxI7KiV5u0mSCXjimArijtG?=
 =?us-ascii?Q?p1w+Ct2DAl2BoFx6lHkfuIlqXUVXriq5SkHzlQV60cyQFfiTLPqkZk95MvGM?=
 =?us-ascii?Q?UeuVxsBwnPw1TBJwlpi14/GEGaBbmf3hHjdVUu7UaHy8aAxwCii3pDXWvFQd?=
 =?us-ascii?Q?1sVdeoperNmitAHXzB2ns7rJ+uopuk//hdt7hlkGE+UDxZGH2Ytg8hjAs3VU?=
 =?us-ascii?Q?rT7mA3ZBwjgkAyyC5uiIkMi3J7xHWDcsyaNxJcV3Fg8ijz0dA8hv5Kelt9OQ?=
 =?us-ascii?Q?vPRHlevWQuflR4e/s/e02MgKzPvur0DOPdD349ygBYGlzBsgCh9VKdeNvJJ8?=
 =?us-ascii?Q?ftZquGWwCrftelCd/Q2JC0YJlmh24yRnaHsdf7EtHpVtZMcoYExu4cMDzVa3?=
 =?us-ascii?Q?8SbnX3vKb1UK5fHXRab1RwrUuuEsC7TdxP6EIVtVPXkVcQ+pylx1KVUpIZFI?=
 =?us-ascii?Q?Kwy92qd0sbJRZbTqWMBJ1ERAkc6bDmtepf+xqj0veMRa+tNMWMFbqRhIPuh8?=
 =?us-ascii?Q?uH20MobATktIkRHe7mC7tUPgobjxfJZ/c2rcPh93x/m9futwyGA9swDfksXU?=
 =?us-ascii?Q?+Y0+mA56vGvRjQ8FBNxCzrRoLVvOnrc6LA8AA2PwiKouUJWXSeEsBjpNpHlC?=
 =?us-ascii?Q?+F/thkR3fgMTZrksnzfkZG+8zlk+xUoZAsgTcIdT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ddb460-09e7-4727-0a73-08db1fddb4e3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5979.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 14:02:08.7474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cdbeg2ynMe4aO1dOc6XiBfqsvYxhq+YAO6PYf/Mytc6iwm3aVemMUTUI5sb6pmNZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6634
Subject: [virtio-dev] Re: [virtio] Re: [virtio-comment] [PATCH v10 09/10] admin:
 conformance clauses

Wed, Mar 08, 2023 at 02:44:08PM CET, david.edmondson@oracle.com wrote:
>Jiri Pirko <jiri@nvidia.com> writes:
>
>> Wed, Mar 08, 2023 at 01:59:10PM CET, david.edmondson@oracle.com wrote:
>>>"Michael S. Tsirkin" <mst@redhat.com> writes:
>>>
>>>> On Tue, Mar 07, 2023 at 11:04:33AM +0000, David Edmondson wrote:
>>>>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>>>>> > +The driver MAY block use of VIRTIO_ADMIN_CMD_LIST_QUERY and
>>>>> > +VIRTIO_ADMIN_CMD_LIST_USE by issuing VIRTIO_ADMIN_CMD_LIST_USE
>>>>> > +with respective bits cleared in \field{command_specific_data}.
>>>>> 
>>>>> This runs contrary to the assertion "The list of supported commands MUST
>>>>> NOT shrink", given that a driver is told to assume that
>>>>> VIRTIO_ADMIN_CMD_LIST_QUERY and VIRTIO_ADMIN_CMD_LIST_USE are the only
>>>>> commands initially available.
>>>>
>>>> Commands are still available just disabled, the meaning of
>>>> "MUST NOT shrink" is clarified by the following:
>>>>
>>>> 	> > +after reporting a given command as supported through
>>>> 	> > +VIRTIO_ADMIN_CMD_LIST_QUERY the device MUST NOT later report it
>>>> 	> > +as unsupported.
>>>> I will stick an "i.e." there to make it hopefully clearer.
>>>
>>>This puzzles me.
>>>
>>>I can see the point of blocking LIST_USE, but not of blocking
>>
>> What is that point, I'm curious.
>
>I might restrict the commands permitted by a device before handing it
>off to some subordinate less trusted code.

Hmm, that is theoretical, or is there a usecase for that?


>
>>
>>>LIST_QUERY. What's the purpose of this?
>>
>> I think that this might be just for the sake of treating all
>> commands equally.
>>
>>
>>>-- 
>>>Time is waiting to explain, why refuse?
>>>
>>>---------------------------------------------------------------------
>>>To unsubscribe from this mail list, you must leave the OASIS TC that 
>>>generates this mail.  Follow this link to all your TCs in OASIS at:
>>>https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 
>>>
>-- 
>I used to get mad at my school, the teachers who taught me weren't cool.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

