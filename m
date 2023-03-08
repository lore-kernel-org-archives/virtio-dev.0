Return-Path: <virtio-dev-return-11521-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F2AC678D5
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 13:05:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AB9012A824
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 13:05:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A5A809866FC
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 13:05:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 98F569866ED; Wed,  8 Mar 2023 13:05:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 73F819866EE;
	Wed,  8 Mar 2023 13:05:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0wcVhyDWy34m9KQAudzoI9R38BrZIFbL2kLcvTzwm1eMhpkGE04Jzh3vT5CPh9DwAj0bJDa/96kEokPopoBhSVi1LBY3UtGkcSn1bx+FxlTPk8G3In8J1Nac1NrxdOm69pnQasFnuEtlU9dOfvqdxBmnD+iVoVd0qDGkWOudgtzF3v3Bxoh8ULE6F4oMLh5UPyvKYRm8SQwdyYNIxS4CN0Lq+LOk4nrhbdkuX3ru9gKAVDKH7rWXGuq8fMUbRs+s0ZF1QGEqudYhCzHj0eMgMEutXZI7GXxjq1BkxrStDWHsjrYuYO1KswxadgVYkZFlG0onoA3xKHPfiLkOZwcew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3OuO/ADQtTE5pzjyjp5Ffd5oAVnX3fsyTwcws/lMOU=;
 b=E2Tr/3FtZr8ItIn0eU240/orM5AYbqV8z2L1lwZOfxZrS+28iYoACSsRkOnXk56IRPejLhJAyMHhBqVc86n/LINGD2Q3oH1U8OwyWC+cPlGpIdMYyl8KGYDzrWCEocGvKDBzkF0j7Ayu+kOLw3XX4Z/0DA4xSdnB3pwr+UCHRkIo1LRQ/ZuwUzKvX1Vl9qaNWuhWl/PLMGfLJP8aB6AgTzIKONNnw9PWeRsSGTo3YjBJ2AmfTPD9T++5GWY0MeNPZo39rgujWJ5yDSPy8UK8zowpErH1XB49sgcgmkEr9kUXirRn8FaIEC+hp0/K594kWY1Y1PFzSzhEfFDCt/o6sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Date: Wed, 8 Mar 2023 14:05:01 +0100
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
Message-ID: <ZAiH/d7igeVCt4WE@nanopsycho>
References: <cover.1677761896.git.mst@redhat.com>
 <6677477d48dfc234d3d1a339fb39d8fa2a3b983d.1677761896.git.mst@redhat.com>
 <m27cvszuta.fsf@oracle.com>
 <20230308065526-mutt-send-email-mst@kernel.org>
 <m24jqvz9ep.fsf@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m24jqvz9ep.fsf@oracle.com>
X-ClientProxiedBy: FR3P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::19) To MN0PR12MB5979.namprd12.prod.outlook.com
 (2603:10b6:208:37e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5979:EE_|PH7PR12MB7138:EE_
X-MS-Office365-Filtering-Correlation-Id: bb975ae7-ebb2-43f8-b60f-08db1fd5bc7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WpNRmzRfNqDYFDVCozS9KV8M/QceCSgAoR9wFEsh1yCk8JLhlS+wZlmGh4oHc67Ft58psK6/Bt2X6WB3VJsrUbA3SrbK/IH1tuSErM+KEIfojo32HEJihxYRd8Gheo+sHuecl9I0OUD4QzmyXEc4+J0sJKAjIlm2tpKvxE/9+3CE0Qig6E+u+YfOMl2ND1PXUqTQD+sGTv+DhhEtsIsiMXhl3FG1K3qxVVd4Y9kbmnfoyyilTI221ESpy++Mk6rae0yxm6rb10+3/hKESrSoLHo1TgYs/SkaLZctuP3S+F4PIYsP3IY2a27v96NuFnzZ5z77yTpflkMhIwN14buQxtVv8ZJ/9Ja+BMP+KcNkevhrBbPujU2dDC6Y8uDtJKY3F8QxEWRBTGb42pjZ0dd2xiMdtGF0Egh4Pmb/ZOGdwooVxkb6L5XRdtimoou32mqzZ1zjs8QSOps7iescFmEYn+NIcBd4LO9fW2OoFr6UpxcWBtYrDjuB+boiLxDdigEdWBO3UQe3Sx8ylVjVzwl0Xw/9qjDRQ4hD6qpqXD5my7AoOgb0MfIk85ORdcnoPkfL8kLyEy7Xbkgz9DrUWNPXJNUDfQOVpkxPLHEDG/WSM9WTi7SNMUwXREFIdSs+mFnBE5UUvTwXZljE0aTVjamgCBv/cmVxE1JgUxNL5AKhLJ8pBmYKQeh6FD1kFfIoGExG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5979.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199018)(66899018)(6666004)(83380400001)(478600001)(107886003)(16799955002)(33716001)(316002)(38100700002)(54906003)(6486002)(6916009)(6512007)(9686003)(6506007)(4743002)(186003)(26005)(86362001)(8676002)(4326008)(5660300002)(7416002)(66556008)(8936002)(66946007)(66476007)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PEDKXare8KWtCNiGsFMeKVrxsBwGfel+/QvcGpQEEmyVOjXq2isKvbGfx60C?=
 =?us-ascii?Q?W2Tn4RbYZOkGOcH4z8sJMvwXwML8qCuBrhDvqqsjxT117edrQlyCV192/425?=
 =?us-ascii?Q?eIOLem6MQcZUknsoCYsd60+sjXS6Dl6t9rm/lYmG1nVTX5dDViOYBYSKYx6l?=
 =?us-ascii?Q?wv3RYy0J6v3uEXQxzABmBr/GKzt3lN2rjP4CtZp7spA239GqjSM1SizIH/z8?=
 =?us-ascii?Q?JauE76qQP+vj4LZBugm5JYQDavRM51E5GdNl5tbcWk8K91wnOAYLGO6w0kSb?=
 =?us-ascii?Q?pevYowB/DPiYMsTVQ2/gsjLSw28pyC2QSYA41O3sE4NkVP0IbY2lh7w8EbUB?=
 =?us-ascii?Q?Kxq4YsdXJznLa9o9Eq2nG3fNwM/HYhy6aDZkrnwLAxLODfAZNvWFtxIv0GQE?=
 =?us-ascii?Q?xqGL3QKU0/jQiwEnx4OMEzQGw/gTtPkc4610ORjHAkBflhqKLDj/R1jLWrDa?=
 =?us-ascii?Q?y/DtwNt6nsedBD/Tw3S1sGKtxkNxUvRUFYYPSFmQCApdADTXDznE2eXUgXDv?=
 =?us-ascii?Q?QUXsaRUn1uPfcVsoac1cF1OxKlrA1dNyHAEAFyuZeXdXGEMpg+9oNn9+Wcq/?=
 =?us-ascii?Q?BHIQ69EpQKltJkaZEtQX0anX9gVOVMdkNslCnOQucImCp/mHPEd1OliogLK7?=
 =?us-ascii?Q?V312pbMaYEKpIrmvMBkWUVXy5osSPGViLCwq9oaJGpl02Yv01NckH/voOIwp?=
 =?us-ascii?Q?ueIDBNQCyYtfc4S7pYwICD6S+GQKZ1CnI/T95P2cadYCmaAbD3AVM7tk8mwF?=
 =?us-ascii?Q?11MU2Lp2WYMRlHciRYNhlZPr4xZJ9VUhkXF7kOV8Z900Fw9q7lsY204wJIch?=
 =?us-ascii?Q?ZHjlrb4tqV9yCLoAmWosF8J+I464gYEXr+h4kk9MDDJt5Ir3GgRc3O+7YwHR?=
 =?us-ascii?Q?vim+ZXnzkjG6UA1QrOhyoHi3MQ1V3I/CWH5JefbLgEPYNo7i+GPLLOa7PzNn?=
 =?us-ascii?Q?nlcUmZ+KBr2mBzSkapspKPo+DRTZIBs9L4iMA7NXp4vF4jNJdcZ1I+Zo37Nd?=
 =?us-ascii?Q?4/8DA7zlDPxJfmtuXryhQ9/WQKf4oNdSfAgJKryZ6KyKobwaEZjIKdPSqgMT?=
 =?us-ascii?Q?PVKHu2ARBkgGxyvrSQUdJWMGXvtx2NftmP7BI6ZHRODSTBFSoWgz1XDFUrlK?=
 =?us-ascii?Q?XKtdaO5qfrOPAsrsNmjx0r+Zu7GdeMsIf3gwlUhE1CR1sbWXUvrsoQbtlrrk?=
 =?us-ascii?Q?vLnZZS0SmQe/lfwzXAjz9cNUDDo75J9ygYLZ6kDc8pBJPq1cC3Zr/Jer0+tv?=
 =?us-ascii?Q?L8jSYCsfI1IZc4iw9zbWfyS9eRBMTBpYRsJpymO/LGZkzi1z7rZNUFokGaHn?=
 =?us-ascii?Q?EVdBcNi95ZrdND6pzQoVUnCyFGO/Fb7fShqegJ1KGAjGayD/nlNKUx3SAMif?=
 =?us-ascii?Q?8o4lC+i3DWjd+9ABGLNAPb2jiYoegNJFkwXy0lTDnyttH7Ru534I4yVfJV9c?=
 =?us-ascii?Q?45A0r2WMlnz9nozcaWy5tS28ZKJtKauJnFKVOmS5yTlBUePwX2UidRhijhhW?=
 =?us-ascii?Q?L7G55XDolMnAQTa3dIS/NlG8dV1KvuhJf2UgTMnzVTNdLO9/w0PjtuORg92p?=
 =?us-ascii?Q?HtfVORJvueLAeTH/HlC7G/qNPEnT8Y+ek1Yy0074?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb975ae7-ebb2-43f8-b60f-08db1fd5bc7a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5979.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 13:05:05.5429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J+RgRC1NHHuASCEPyBQlZZ0RtAhFblS4eyHn93oHE7A+riMoBeEbckNVcSTDGZj/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7138
Subject: [virtio-dev] Re: [virtio] Re: [virtio-comment] [PATCH v10 09/10] admin:
 conformance clauses 

Wed, Mar 08, 2023 at 01:59:10PM CET, david.edmondson@oracle.com wrote:
>"Michael S. Tsirkin" <mst@redhat.com> writes:
>
>> On Tue, Mar 07, 2023 at 11:04:33AM +0000, David Edmondson wrote:
>>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>>> > +The driver MAY block use of VIRTIO_ADMIN_CMD_LIST_QUERY and
>>> > +VIRTIO_ADMIN_CMD_LIST_USE by issuing VIRTIO_ADMIN_CMD_LIST_USE
>>> > +with respective bits cleared in \field{command_specific_data}.
>>> 
>>> This runs contrary to the assertion "The list of supported commands MUST
>>> NOT shrink", given that a driver is told to assume that
>>> VIRTIO_ADMIN_CMD_LIST_QUERY and VIRTIO_ADMIN_CMD_LIST_USE are the only
>>> commands initially available.
>>
>> Commands are still available just disabled, the meaning of
>> "MUST NOT shrink" is clarified by the following:
>>
>> 	> > +after reporting a given command as supported through
>> 	> > +VIRTIO_ADMIN_CMD_LIST_QUERY the device MUST NOT later report it
>> 	> > +as unsupported.
>> I will stick an "i.e." there to make it hopefully clearer.
>
>This puzzles me.
>
>I can see the point of blocking LIST_USE, but not of blocking

What is that point, I'm curious.


>LIST_QUERY. What's the purpose of this?

I think that this might be just for the sake of treating all
commands equally.


>-- 
>Time is waiting to explain, why refuse?
>
>---------------------------------------------------------------------
>To unsubscribe from this mail list, you must leave the OASIS TC that 
>generates this mail.  Follow this link to all your TCs in OASIS at:
>https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

