Return-Path: <virtio-dev-return-12492-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEF9C77B7E
	for <virtio-dev@archiver.kernel.org>; Tue,  2 May 2023 07:51:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4EA9014568D
	for <virtio-dev@archiver.kernel.org>; Tue,  2 May 2023 07:51:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 45FA29864A4
	for <virtio-dev@archiver.kernel.org>; Tue,  2 May 2023 07:51:25 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 39B1E986466; Tue,  2 May 2023 07:51:25 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 24690986479;
	Tue,  2 May 2023 07:51:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fo0c/x2qylCmSh8PbjEbKet/J7p4j+YFcQvyya4ugZFbrqadC7azjR04hjgmuQ8TCcsdz/YVhpKB8LpRA68Qg+iK4m/dUOEn7q7erSIN3wMrztgaA8P3BUzrHP4GWnSG56Wt7PH/H76Dk9qF9t15WTr58YAyfhj0nbwyfFZ3Sg7lSyNAB+fJrqWM09Vu+Ho3sJP0Kmbi8ll/8NgBDiebrdGgWjPenZGymw1//lDjYbpWmCUrx4x4jIf5OBkIvRZ1P2NvurIyztIM9EFxb08yXcwhLVKE5Cg2+sQwWhrHt5hP9mZ5/eZCTUMrGlrtCjqSQ/OrvUMaLC6LIqjBanXSuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCydgkI8t9h0vpWSekiZAWb4KLUhpaXY1V7iVf32R3A=;
 b=OG8tp0FY6Xb4Rp+XAguCW64e5simSwoAe/X533TCfRSt/7yWP1xaJW7wjptkhP32oBziXKPU+/i1/YupuQDxKAsqSpehZmGZikAhpqCjY0WhS9vAuPjodXfYVBSdlu7ZxJAGAjipISROA4lwItV6G6DMorbbz0qDHGItjbmrv63NkGAI2lNjvx69hHqXzpLtPp5Y1rFliy7M/9EExMFyi+YX86OMj54RNTxOc5se6iVtIPQpd1cG/kSQKBy4pmEpHIuDqIYEhOVGnQXX+UjRYj/AS7xVbgVlng4OKDbLmEtcMHgV0wfaq5vyQeuF4p79GTgohSUoxjVtC2AjArTFlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
From: David Edmondson <david.edmondson@oracle.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org,
        virtio-dev@lists.oasis-open.org, jasowang@redhat.com, mst@redhat.com,
        cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com,
        nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
        Zhu Lingshan
 <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
        Shahaf Shuler
 <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
        Max Gurtovoy
 <mgurtovoy@nvidia.com>
In-Reply-To: <cover.1682354275.git.mst@redhat.com>
References: <cover.1682354275.git.mst@redhat.com>
Date: Tue, 02 May 2023 08:51:08 +0100
Message-ID: <m27ctrw4r7.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0654.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::12) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|IA0PR10MB6748:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d3effc8-109a-4f6d-dc84-08db4ae20125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	fdrquniSt2Rv8ShS0aif01mAdyVtYA6gA9reNbWAovE4SeYvTLeAVFzVQcATX1uXfH3Gsdt63+hyHr4+vQ/jGbsiCjbIxNLjZMv/1VM3jxykA3fLnjOu60cvz9S6B75Y3AA+9mUeIG6waK9zXbS2zO2JG6s+W1zpdM96i/G5dCEswdhJgj6lHEJraYRaieuHfaIaDI4iKgwzC8g7zYFNJxJbWWDm9S1vWyTNuy2vSGNTUqsDmh2jiD9h9Jw/TW2Y9sbkQo/XxyK10AiWpuxhPTd0JGkuFcES8ZzV86QDLwsI/sJoV+zUS+eLsyipxZIBfkIf4FdkkVCgwln5DJsAqaZxPNhKdn4tBcfq0JEPMQPOEiy8XWUSZ6XmRXIaHEXKmIoTccMqyton9w7T9OwJ0tUqDnfzgAc6Ti2Ryjh8YudTTmDRZebJNYEJu0O8Ry5M7GU6dvEokA6tx9HHm9hApJpJ/Q8TRgCBmrOKlzYaWT6WwCnj1v/nfr9AgCXyOifzyI4iYwmWZySWN9JDMD0IAEDGpnePtccYULLNrQuwd1fCE31rrM1JOD9DqM9+FzgmKHq4BbCUFALphEPJv6WiBhKqdH4RXgDswyyxdfkXIQI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4926.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(136003)(366004)(376002)(396003)(451199021)(6512007)(6506007)(921005)(26005)(186003)(38100700002)(83380400001)(2616005)(8676002)(8936002)(7416002)(5660300002)(41300700001)(36756003)(44832011)(2906002)(4744005)(478600001)(54906003)(6486002)(6666004)(316002)(86362001)(4326008)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?lpH+NVGRCB6GGLGJEIxhwj/6q1XND0oN3SzR+hRU3mFzYzHf8HKWgPQ3uJF9?=
 =?us-ascii?Q?ix7yi480Y6BBa62fqkNJxaBAxcO5zh5Tx13x83HXmbMwwb7NwWnIE92hH13V?=
 =?us-ascii?Q?AtBRgBBJGTcOnkxpm/B+p0BdruHGP9ehpvoj6dXxbuFQg3b7QuFl3NwkRP/y?=
 =?us-ascii?Q?NEfQY7CGUEdjxaL5Ba0tmzmwhZlGNiKP/v9iIeNHactC03fs8wkz8bPFFcb+?=
 =?us-ascii?Q?z4o1/hjcNu6IMfiTS5VvpUlipIJKsBFSkQP1YVnSJ4d0kRdCYDcf/AJe8iEP?=
 =?us-ascii?Q?EkGCgt7gBJOn+q3ZGNHG1WzYLC8m+fwm3lSbLVabcjKTUjEQQzlxtGU+5bBX?=
 =?us-ascii?Q?kv3di468Cx7xIsthGd9Olk8H7jF82rfs0b/Nf/JPILc5LCAnmnSxHPzxuq78?=
 =?us-ascii?Q?gvZis2zO+//HT+4nRFzcEEX9La3VgJIJOLfy5sUgWrpkejP5KpFQ2Zn68IRV?=
 =?us-ascii?Q?DPrWr/oc3HiygioUB5kuoY3clVJY1d7PX7pfoFyw9NNXjhWDsrgVWQ2HfqMb?=
 =?us-ascii?Q?55iR6TsqYKmBBJGJN4NZHbuBdRMim+TKOTPzI4r6MU1dq0VTW264IcBul4T1?=
 =?us-ascii?Q?1ArfzgvwfpEMnTYafW4En0hfmNjL3hzNLgFCM7gCQJsO0EUjU4jdLTMa4LQ9?=
 =?us-ascii?Q?6UMxHmp/ikmTNu+LNXJ836vUUNCf3B9PSrQzHCA/sCbZiU1vXxCIrLLj8oQ3?=
 =?us-ascii?Q?rMke30Q7R0Vt1XS7uqcex9cA4x1MYtrYjIad1WAf1jxL1oNweX6lk3BJ0tQl?=
 =?us-ascii?Q?0x+/1goZ9mfCmxCulkua+JbWK46fBYx2r5JokOVbiKajD7+AU5thML+8GU1e?=
 =?us-ascii?Q?IUGf+Ztq6VrFhMHJR/2KR7EuqpYxCgl+OYKpeQwq0pIfxXXUXw5CWg4QSwPg?=
 =?us-ascii?Q?jVN0mVu+NoAoTsylMqC3oaErOQUOedKc4t8Uy+KfvgDWStXDRsdw045OSNjC?=
 =?us-ascii?Q?z3s3W+m6JpelcBG/7FouZ6hTCly4msOFesN9ZxirdcZKVssl4jF10k538Meo?=
 =?us-ascii?Q?6lNkdGvsR8qH1XSA+L7RAClbuYzB4DaK5ccGQwgiDoAj6O25/k7BZaueimK8?=
 =?us-ascii?Q?AA7dbQXlcylmAixBMbiEFFENyaLdPwWJRZOFdGsnXvbVg32cLMg4DyBocU24?=
 =?us-ascii?Q?IPQnnLgGZSvoLJl0V9pSl9+caiY8m/hLogCAQlqo6I/HrY3uohiGx9KGvFzq?=
 =?us-ascii?Q?QphyYQEuWnh2qw0pHJ6AV28MCQk5yR9juuUxn7gh+9so/Kakyysy+Buc838a?=
 =?us-ascii?Q?+SEtyupWUIXJA7RkHJB+SslF9SptEult8nglj80Wp+/TX1NUUqsS6tYoVOdl?=
 =?us-ascii?Q?H5OUSrdryxaukRlEXPmpgOeSIWN0b/qvapsjBJ3QfevNuZL+ji20EP6ZBqwF?=
 =?us-ascii?Q?kEAJZL23e2XgU4E6NAN1/suN6TxyukqlWRm8jCz6Z0Z0GhNfYmxuTOaxxbz+?=
 =?us-ascii?Q?lF1Xa77GpuR4rvOZ2+B0DHfaFzy1hO75JRSfuqqp2Y7kLuiK6Oq1oxRtKwyi?=
 =?us-ascii?Q?w6EFFBG9VTI3CPB0TOBZ8cP3+QC6Q6sOlqJSw2M7IFj6f+xMMgcUr7K8OKxR?=
 =?us-ascii?Q?tKKydSl/uhS6pJDT0T/cw1h/VcC79KWW/Om6h6C6FNo73yqwXNIJP70REwrR?=
 =?us-ascii?Q?xg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	wu8ohBHoRE5cf49QZKS1Cdv0zeDiO4Bz2BeOo3r2vQolxEk6kXPRUdo89Yb1Y0NR/7meWnjWcnn5QIMCJrR4idX9MEp5CfOdzdJJLsbIK9G0QIdvUNLnwRWNa7l3XvAJ9GDX8Y72H5vHe8wTILbbQhrYn3OXRoweyCdS16SL3pECi8wHuFvglZ7Qhz3iFOWHLJka+9B+zYcE3dEU+pZUcRdrJgdv1ur6baTQTMpcFMlJ5AX7ZPxb+O+TJ9Uy5xbiDBChsoQg8yP06NdESaXlOC8XAuBg9PaEdDc06LnPS6PX0CH/buWnbo3xXVsPGzvBoVW8KkDhyEKqZLi+AaE/60lw0skvQpc8//JanRYwAlPCIG+RsPXO1g3apQaNSEX4WaDmOOAD268COnGh29JQSkGIil2mxbGgo8nhKh3gxO2su1G0TY+akb0OhcVb7xbLbaX3NyHvhZ26H1htD9S8oBm1mLv1U2Ce1WetkLcSrUnVfDPX0bX2QDWFci7B2pz4T7MrWw3jDhuLqEsT9KBpuVtxmtl75kcZ1XJkVRtVSMDljWt5/hQ31xXZuEv6asI9dk1J0Ls9JLzppCXEOgsAWRegILUfK1YXPYR70U+rWWM62rM8Zn5wZUhEXx7O8DqohTAMX2R2L6ooCn6N7IJ0CttHX6wpVd1XSoEf1MyQ7ItGJww48W0VTymIesJWsfnqlgTO/1SPgU4zKG6Oy0ZbIgnhXCkE4iCoh5UARpjnz7GnHRNjNLMIOymwu+wcxZU+hP5dnbikMLv9c3VzebCUp1okyY43CjHzpjIklpbtVKlejxbtNPHH1ZQK3Ukq+pBYLAl6O4iXeqNStB4xgbWsZMhzUXtYL67tUOytLhBLZFXFlX1MTxtsbdKMeufdurIvSr8tHPlHw/IRLY35bQkXtQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d3effc8-109a-4f6d-dc84-08db4ae20125
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 07:51:14.6908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UE4aqX89sLgXabzcoqKIm5wHrN9JZJ43gk0SmAqQLLNwNVOQNkUOGZTa7Q9zWgd5fTPA/FR3tnxfO0IWAVvZ5bPV2nALyduOMeku9DY0BAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6748
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_04,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305020068
X-Proofpoint-GUID: OaQHgjRil_7i48PQWlVEpjPtCi233HyF
X-Proofpoint-ORIG-GUID: OaQHgjRil_7i48PQWlVEpjPtCi233HyF
Subject: [virtio-dev] Re: [virtio] [PATCH v12 00/10] Introduce device group and device
 management

"Michael S. Tsirkin" <mst@redhat.com> writes:

> comments on previous one have all been minor, so I hope
> this means we are close to merging this.

Is it possible to get a version that is merged with the split of the
transport specifics to different files?
-- 
And you can't hold me down, 'cause I belong to the hurricane.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

