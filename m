Return-Path: <virtio-dev-return-11820-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039BEC6FD18
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 16:16:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 44F271318D8
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 16:16:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3AF4398649D
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 16:16:52 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 301CD98644D; Tue, 28 Mar 2023 16:16:52 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1CEE498645D;
	Tue, 28 Mar 2023 16:16:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWm/qiEpIdwPmWfk3Wna4sWi2BRmjebMLpiDAY6cM2XpNaErjlgbu20BeYYvzXcN7jQIhT9trR6/ehbtfR6R/95t4ZJpKr/JjotvTbD9A5yMEgzvG73ZbADQG2W6VkzLn+4Ug/OSjEwzY34RoDUWGhnXFFS+fHtZSewOOOMQ+GoYg/pHIaP2BXpT+9j1QqD2NQTzHYkN+6emoslBHHQjb/vcOy1Crcl8ATdiSZuPDDQVCRDu5KWtg6Fsv/GCp4h0BXWHtynI5eRtNNSRLsIMisFXIcpTRv72uaawchoaC2IZjtHs/yDpm2hIRtW27d/a0SgzAOzdtn2P0BRGXFGocA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJEuCBHPWAgpMX8xExXEWC2ZNFX3aCr2PwpKNNafP5w=;
 b=hikHch4HRqjQP59Bl97tlGf7NtGlX0+9FEK4iWnox6+URHCnZtuGEM6I3+peqULvVFCaWAA7NBfCIAO1qhq6tjpOT151N/guwGbmUObyVc4cacuNylKKJpR+TDWQX/u4K0FIq4yz7SgiCZ0AJ6VgdoYxzB4X32eqGKMhAX5Jk47L4emk4VBPARzRD/vaOT614uZO3wWvnnCRx/HzpX8dRWgidhbrJNp2/GYoCZGBP1NX1UFOJvyOBmqndXg3MiUby27LlQ6Ei81Q4LGy1tfTUBSjbz5ANzVvx5JM4tANEcYY3ZwlC4q9ouh3LSPFdq9TnDE7/zw6lhpg550KC2SlUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
From: David Edmondson <david.edmondson@oracle.com>
To: Parav Pandit <parav@nvidia.com>, "mst@redhat.com" <mst@redhat.com>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
        "cohuck@redhat.com"
 <cohuck@redhat.com>
Cc: "sgarzare@redhat.com" <sgarzare@redhat.com>,
        "virtio-comment@lists.oasis-open.org"
 <virtio-comment@lists.oasis-open.org>,
        Shahaf Shuler <shahafs@nvidia.com>
In-Reply-To: <PH0PR12MB5481B571104CA387FCB74EA7DC889@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230327235936.414196-1-parav@nvidia.com>
 <20230327235936.414196-6-parav@nvidia.com> <m2wn31as15.fsf@oracle.com>
 <PH0PR12MB5481B571104CA387FCB74EA7DC889@PH0PR12MB5481.namprd12.prod.outlook.com>
Date: Tue, 28 Mar 2023 17:16:34 +0100
Message-ID: <m2pm8sc0m5.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0072.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::36) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|BY5PR10MB4180:EE_
X-MS-Office365-Filtering-Correlation-Id: 207e5f13-acdc-45f7-9768-08db2fa7d039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	GrZXsaws8aOnAr2MVzJTMfjTOySwo4CaJ80uQUzsw+d2GCxLOTxI9LpunRQZA11fClt8qlpv18DxQaBnn8wl/OmzdJ26tDpHSBQYf/zcJb54zxrE2MnMhSqrxFzHStk6Ms1fGbyv/WRn2odYVX5CmZ7LOQLFfC8DV1+uyfxcFZk94FFjYnHkT/PMi7GWkELiiDJN0nQZmWbyi4/IqtogqT1WmXCkdM8p2fd7yEdQBksaucPsTLxPL8tFOcU8vs6vnAqsOwmnOjO4SoR/bUGTH23+V+ohnH1uZwYPxTFFHdvIH4znFIcvolMnVa3jp/TNladeXpFyz/ATPTXrHSa/nPp3WS8nC0a8JYMgFZkX1GE5hOusqdn2GcL93mrHyZ9QHkii8LhNPZj/MS3op/n1cOCh303eHDL77irzardOVMbp16lnOWbLjys9MMRb+tNvJkvWVLwkcoZ03kcozrEqA1plpnktFVTe72xyqKTgwCLH00qZCgQK4MtVFmrLMtl4NG01SgMfgCYrt+nzbZismWupylPFkkudUZhnp6hMsPpQAYseUJVumzSJKpluCUH0
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4926.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39860400002)(396003)(346002)(366004)(451199021)(2906002)(4744005)(38100700002)(44832011)(6486002)(66556008)(66476007)(316002)(41300700001)(66946007)(8676002)(36756003)(54906003)(5660300002)(110136005)(4326008)(478600001)(8936002)(2616005)(186003)(26005)(6512007)(6666004)(6506007)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ddjDjY5fRlI3stHzNfrPmL8dKnXqOX78bw3d/Sn2pqW1SEzM+rRQvcb0x59G?=
 =?us-ascii?Q?t5LHDQZxNWNzGWUOJgcXbcIwOtRwkIgNPRHVFMHmugJL+89rupyac1u7/esl?=
 =?us-ascii?Q?WRDGlfO0S/2amjb5CwX97Z1IwVE3PA5VO2qcvTDXXe1y/XGIAVJwkKzFh/TA?=
 =?us-ascii?Q?dia1xDC6q0smkl+rXR9LE0KhMx5FEJT5HWOlcXnqee+RLCsBegslWQ3fHgZo?=
 =?us-ascii?Q?WSyTaZk+hvD8Tk1J1l0t3LIwgXFsTCJHVl2qb8QONJFnM9Y47aFCOTKYGQxF?=
 =?us-ascii?Q?fVUJifKZZvkiMk5Odad9L0Ag5hMUBI4MmDroJx3EVrzVZdAJXOOog2Z8TOEw?=
 =?us-ascii?Q?dyyKoJbkI7geT4QqZBgoL04Bbwe3DL7yKJ4ZSLknNiFjtYj5yGLUezPhJNzu?=
 =?us-ascii?Q?CYE32UteTc1m4JOBgt/MLDSii2Kw08w6zDGxch5d9o9o9osIGaskaiNp2Y6O?=
 =?us-ascii?Q?PIZV6M4K1hUO96nYez2gZUol9nVw5WaLbX15Wr3/ootDWTSsEVhJt7S/Tc0r?=
 =?us-ascii?Q?z8JFBJYWBmOR8q/ylCSyQoYOGaF10thVaYxV8Vh8rDBZNwmkAtHC44YfN06M?=
 =?us-ascii?Q?KbPhCv7t0bNMA2qXBHGHrQusnsT5i3vIt9a7Z7Dx2z91tvVOB3al5NcD57NX?=
 =?us-ascii?Q?Tlu2Kb+2DhqLdjMycSuaoT8YvPNeRW87T69qrxJF2c6v/M4FjTKOp7m+/bMf?=
 =?us-ascii?Q?WWsSch61So23wEWhW97f3LGsHR9v7ozAOI+i3vskxrCysaSKe4r+UMW2zNz8?=
 =?us-ascii?Q?eOKCbE/oTgv40iowyUhi64ElsEjK1xrbeL4p7IDfDpTGZ4b60mxF7fR06dAn?=
 =?us-ascii?Q?vKwd2zvb3NW5dMB2yexaUC0DxnbbvKxXXzKY6p4B9hdIG4WSVIcCwI4WOkFE?=
 =?us-ascii?Q?hxxKbZY/0vyJSbC2sEEdiZaVigP1TY9n//j2cs6PGqE6e/vG/DctRxpmF4PA?=
 =?us-ascii?Q?qDZ8/WNNObxrm6BvoXK3Y4AMBZX+HhkCU0EAQogSlMcmPfmjcuwt3kjndn2y?=
 =?us-ascii?Q?uuxmIgCZF1iB1BPdQJt6Ho6r1iYdjGouALeRuUXk1V+YvzOp2BP84BS2z2WT?=
 =?us-ascii?Q?Lb8251bUBBYr0HZqsVh5GPd84UZ96Szr0AbA09+P8RY4Y6bxs6HLSaXw9J76?=
 =?us-ascii?Q?cV06nB1jMzEdGXpEGeWrQ1DJHD+Qo/Npjwdrj13Al0f4ZMC3KmXlr/1kbnz/?=
 =?us-ascii?Q?7qFG1tfgQtQdczRCwDj3AWF+woSoejUnFHkLv5gIkTJgSgGgZhn/i9mGiRbN?=
 =?us-ascii?Q?cjZNjUkZog8F/HI2fwVDdL3OZUqDeMFoWtthwn3CY15PDRTtGDveYczc9QjC?=
 =?us-ascii?Q?rWK6sAj74geqt4oZzBJBKOA2Tf89WW/3hEIONPoCUUtSHCL6UaW4auFVN6gw?=
 =?us-ascii?Q?wbaAV7767xsjpe3gI4OrHMwSiq44J2Myc0w7m3eyU1dTI6ZVdKICrg+ex+Rr?=
 =?us-ascii?Q?/xw/YQJnF/y9CuHlv2YNinVIuNHM2mAaWVY1AqqqM9n7rpHdEc3vRp3Y9fHX?=
 =?us-ascii?Q?L8TNIMp4Q85Hyldfk8VAmHlcEe/L0o4sgWDDe+DpCOYP4CuAKm7vbsagQuCj?=
 =?us-ascii?Q?crxO8VpxXeIMM5AFZS6BP3IiswJXwi0Q7D260XbXq2xvYOWjLyiRB23uKDF4?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	wz84hBu4T+W8/zCQk8C72/Y2CMfJiNy4ebAH2OkbcQZgIedYSniU1OuKRG8e7j/4QXPK4l/sRnJ0ZprnAApIGFyJ1y98Hi3nvLAKOyS7v8qz/tvqO/imDVjIw+BxjSVaN03mwWAZ8g606K2GQGGLpFBApxjVOeJy7WrYhAm79zuoQtzWdb+1TlVm5J7yEnZpiZBou+ZnBd9DyQ0bErIUdvFtwqDYbBx1COHEnYmGNxU8R1OBaGKVqzV9PsUSO9dLjPUja8YlI7PFkCxWDe5OMN9MjcF4JLuHFzEqoZyzA1/1pKZvFyuX9i4/Tuv+L9yygRngpM7YWxtdE39/pUI4DmGTP+9BFZCWlSVczWo4mtcqvXY2UhzPbQic1j8/Ma4VWLTySyTYYqre2UUOX4ZpoJl8MOP9tssCMgmZDFENt0uVT2/kCz+W/l3X7p+C55Ua48LVqOq+XsIvowftqRX163xveRnOfrIxCd87JI2IlWGKwDnVW/HllL5rf1aGdBsiQ76CFjvF/Mxrnuf+5RoNw1AcXZwg2M+Lz4EjBLKDeSS0vPY+qNzqg5JUhA7OeuZsoMRIrM4j4camHoBYMKNBdOrKJt3d7HVbGr4E4NEo4QAVXUZbDRa1WVRKhLOP+DFriA35e6pUxGsHn3dteyJKzJekwVpqMVbtiCgvMY81L+v1QPXDAS0uUrotfMztY5155Bb999fEMJOOhh64h22Cse++CtjhxFfzQzo4pDm0PZxy2w8Tjr/O6e+fCuWaEO/1fDfPDy1hEf4IS+7KIBXcw1nTr7oFWI3sj8VrYUTsaKFjxBd8e7PL+8wohRE3UpmJPzfvSTfFVCclJSwHv5mWVVHYgDoc1h1h5yVqn4U9stT9rt/9Kj/HkNbSUTEToeXt
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 207e5f13-acdc-45f7-9768-08db2fa7d039
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 16:16:40.5563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ciTScU1xZe5xirKHxVKnNZghsGSuIO8iTOQkVqGhRZSiK7xtex5eIwOU2QmN/ehs8Dkko/Yep1YO2fYmuP+BWpyoktY4Pd9YDn+mmFz6Z1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4180
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303280127
X-Proofpoint-GUID: UeSRrjjKvbGeGDla3sS2gw-5WZsv0YAC
X-Proofpoint-ORIG-GUID: UeSRrjjKvbGeGDla3sS2gw-5WZsv0YAC
Subject: [virtio-dev] RE: [virtio-comment] [PATCH v8 5/8] transport-ccw: Rename queue
 depth/size to other transports

Parav Pandit <parav@nvidia.com> writes:

>> From: David Edmondson <david.edmondson@oracle.com>
>> Sent: Tuesday, March 28, 2023 10:07 AM
>> > --- a/transport-ccw.tex
>> > +++ b/transport-ccw.tex
>> > @@ -237,12 +237,12 @@ \subsubsection{Configuring a
>> > Virtqueue}\label{sec:Virtio Transport Options / Vir
>> > \begin{lstlisting}  struct vq_config_block {
>> >          be16 index;
>> > -        be16 max_num;
>> > +        be16 max_queue_size; /* Previously named as max_num */
>> 
>> "named as" doesn't feel like typical language use - you can remove "as", though
>> I'd be inclined to use some kind of decoration for the name:
>> 
>> /* Previously named 'max_num'. */
>> 
>> >  };
>> >  \end{lstlisting}
>
> I really don't see any value in putting this change log material in the spec section,
> But anyways, Michael finds its useful for some users,
>
> So how about, 
>
> /* Previously known as max_num. */

Seems fine.
-- 
And now I know what every step is for.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

