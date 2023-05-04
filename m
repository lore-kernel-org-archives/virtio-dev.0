Return-Path: <virtio-dev-return-12546-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F14C7EE23
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 14:25:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 78F111462FE
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 14:25:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 667609866BC
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 14:25:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 57AA09866B1; Thu,  4 May 2023 14:25:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 421F99866B2;
	Thu,  4 May 2023 14:25:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPJ1nuxRWGNHdkL+U9eI4OSn1krRcXOhSDAZbQ46MvDDpip2HNwazX1MRTx9gRXuRGbjyatOF82VUs3mwj4NT4gjWO4czTGn0XT+iD+SetGa5uavUwCWDF7FDW7qa09IbA1/RTZs7q9JyOfbm6HusvFym2qOU6iYOpKbISCfgtk9Ng2Qbig0Gr4qku5zM7zYu7Sc6d6Y784J0axEtQhiKM23UzFFjxNLyhfxoSC1nf7hpIbxQHLU2yNif3XM9oUjKsacHrc5W6yzVODdO6PrLcEP3Dqv9VMcpUAEWwlBM/VXRvgmH99vi+bjWzKQIobDx4rpboVlH++CAqSsDs/aEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+uhJo52S5svOW+xDphvFGvwSaaLZAHrFp4yswj09Sg=;
 b=c13A7zka1Yxp+AzcyBLZtXVSYM6YEnD40nPXENG00zH7u6K8rDCG8Zbgj0hgH9tu3culNQJFOKkoWqiHy4kbo//J1BHvmZvVI4KkF5PxLrxwb/YPIU4ZJu4EuGLerzy9uwVYmOa0050NUx7J8VsdvO1EYWSstjzjnRBk5JxZiL6o/lOEA3XHg7AjJXR3rQ2xfXs6GXU4Mib3P5yknlyIdJCXmbO4QkDNABjNvYo7BKLAT1ktYKZqz0PtDDY+cshaBJquzbMWEZ9fTBswqS190Qrv44/2m58H7Bmo0LMT58FSR3IEnzrc51IarCVpHN/0EKllCuD0yTjztvzuPSpASQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
From: David Edmondson <david.edmondson@oracle.com>
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com,
        virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: sgarzare@redhat.com, pasic@linux.ibm.com,
        virtio-comment@lists.oasis-open.org, shahafs@nvidia.com,
        Parav Pandit
 <parav@nvidia.com>
In-Reply-To: <20230504022959.547025-2-parav@nvidia.com>
References: <20230504022959.547025-1-parav@nvidia.com>
 <20230504022959.547025-2-parav@nvidia.com>
Date: Thu, 04 May 2023 15:20:13 +0100
Message-ID: <m28re45gbm.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0096.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::36) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|PH7PR10MB6284:EE_
X-MS-Office365-Filtering-Correlation-Id: adb25f94-f5ab-4287-3411-08db4caab027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dix/DfOcPT8PPa81imyTUiTnaAZQ72qjkw8+xx5iWJEJuZ9xBvBuNWQgEH82L63C12o+etF8n0d3txzyINfUPh0YDnFlMxYa0nSBx9npidQNmHSx78dv7CSKjtE7rHzfuHSXOa8Q8X9Y2hj40GoG8SXejBJYUPvyNhW3WxpmHQvZE5+rLmyV1GKR9tuT86+imzIR/VnVPL58o+1tl6gdsF4V4AZM1QdnOseTNa/9Ohrvy0W/S0vmADQqFkWtB6G1CFtwou9dsIC3EIaLcKHSEufeArqHpxWu67Ei6ftgtI4SVX1cw8GFoq+HbWT96reth7v6JP0Hi7aRNrfaQFqA+b4NZ6AQL5+zqMhf9IJfyQnS6KdiZ25vX8PcFy1loJXHdZLvES4AWRFL9AzDT8pPIfJDdIuwLEuEfAjrH1d/+W1zrhyKiUM3fOsccxfHz+KBfQcZSEToq271tGgty9RBmqqXjkVMQS0YorurKGU3RAfWlHr+zS/2iP5EMHQWwBEvx7PDEvXMKPHRzUy0USYcysd1dwB+rNmEVLKF7mQml0w=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4926.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199021)(36756003)(38100700002)(5660300002)(2906002)(44832011)(8936002)(316002)(86362001)(8676002)(4326008)(66556008)(66476007)(41300700001)(66946007)(966005)(83380400001)(186003)(6512007)(6506007)(26005)(6486002)(478600001)(2616005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Wj8o7rqLK70hOtmlJ8W+4Mf1SrPfSN3xDrmXvZjVSNvRBjg7mgMpF1CUdSBy?=
 =?us-ascii?Q?/APWXws9TvHozERboKWKkdABBP6BVpU3R4UoI3wiuOXv/GZtSQS9KIiXfcUb?=
 =?us-ascii?Q?FT9TUpX87urud60U3b3RaM+yV17RWHl0fbS10xRhJhqFcly/zj7yd2OV75By?=
 =?us-ascii?Q?36MflNLP5FMvPvNMnJpsQ1h2IAKv9d/YsjVEF41b0+YpO1QIjpRfbtRMQUWS?=
 =?us-ascii?Q?871ZqbhMJlYFvYFni6cUDdL0/A8knkgcEQcixsm0TLXGe9vhQAlyJkgJUnKB?=
 =?us-ascii?Q?1pVmP5qCnyOQ/sm5vt929jrMm3Y8JAQzOWLc45dLUF0Nh9aMMl39eL7yARCp?=
 =?us-ascii?Q?0oW9fmXcJJto4kqOppNIUPhOXfB+W6KyjMfe67JzvqYkRn96VisBWIWtMwzk?=
 =?us-ascii?Q?I+i1XV1f4bzVVJsoB75z2VmuW+NA85ikmtqOgudfQix07qKaUenVSfd8jJdZ?=
 =?us-ascii?Q?0oooGupKr3r6Kg7Z2uBIozdxuBNdbieJMfbUhqFIV0A8InoXb4DqvCjzJI9V?=
 =?us-ascii?Q?E2Y7LCScgJLWHuGn/hByrZibVwf8zQKEgqx812fUZ/GOJytZ163FBRYk+Wki?=
 =?us-ascii?Q?7yU0RRyAcc+O3+0evfMhpLduPqJ6R2Tg8TxUzhiFS6IKX4sBGqyJur8S+mXP?=
 =?us-ascii?Q?eElUWewCF/yNIhGKKl8n6E+aosbliaZiDAIzvNlciaPmM876gstz4FV6F4wp?=
 =?us-ascii?Q?AlegU8KnXVtS+Bbue/aQAPHcMQzpGsKaC1laR8s5rnWjW46Gc00CHq8ubge8?=
 =?us-ascii?Q?0g9p/d3OWZ6faLqEaep/VSDpjNVTm3jB6xgeIuz0Zlvi0ylEgGX9s1elqNU/?=
 =?us-ascii?Q?AV7lkAdg9/jD1yvR+coahIVlVSgckM/PZDW7sXudOPooBguUGZp+pTCp9mlt?=
 =?us-ascii?Q?Pd5Bt4i8OVByUqltqyntO4Lrk1Z0WsQXL+yKV8WpLzs1qlaK6k1BCMRJkf/t?=
 =?us-ascii?Q?H8q1EGlErK2UjmzaAE9pbAFd+dNRhndveChD7KkWi7AMfrY6QdlqEC31J8y7?=
 =?us-ascii?Q?g7kKGjEfY2X1Lhb1NLYGU6HdXh5Cj9b68CwY5nFRNNdkyJ9ekOw8ih9c0q7m?=
 =?us-ascii?Q?7ZK8yxF4lwO52ySlYRtLiVLpD5OqM6qjJV3/1GMrzjjolPXBmrSMCGqMIUrA?=
 =?us-ascii?Q?GMxkBgA7YSJqH+91V0XwCdxmuB0bjTN4PX2IEcxCJDmc6nbb3vD2zTSJbfrz?=
 =?us-ascii?Q?CrnNvxSq8dhMSnZgzBy9PPaLfEWI6C2nDElXFU+WfpqbzY8e1JvyhSEX9ViA?=
 =?us-ascii?Q?JUTp8enJ4VNe4jvDu76NQD7vGhIxvAUycD3owkI5Ji9Jqo4NjYs2VDMitH8Z?=
 =?us-ascii?Q?5V/asw4GrZbQRSua1wBX5DzuyS9NVL7uT0FXZY62oSxAZIkXdMI0pBtFJFbS?=
 =?us-ascii?Q?yiNYj4sBPtLJHcZO5mfsoX8G8Q6eeJyFRNNSJBWhoc3KFb/i7k2WcZtDAc/P?=
 =?us-ascii?Q?cly1ozJA5k1DkeagTdmivZvs9uf+mWV+iep7J4+ysYywME0ihlxaK9ixZ4aC?=
 =?us-ascii?Q?NBj8VPzdromSVAdbCUjIyfpWQXgEPsl73HXTixEaj7/dATWOEfHjn+Gl731c?=
 =?us-ascii?Q?eQuUfVY6MAiiHGWktnvg5nKmMkg5QMV4ZQfoxoMq4NvcsEdCQDxE9Moy7bF/?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	4ydIwGNaMmPlr9cZnjm1e5MRC3ksq93OMN+Ux2UTSM8/Exbipi3QwC3TnVwaYFtdvd5l7Lox75/Pfalgyx6mLMegt7y3Q7pp9dYphfbVKSvYBFDrzqP038pVt/FTAN3Vu0/+lwTvkvwvEEqw0x8XkR7eR3P28jWU85GAh4+wl/aHGlbbLfnmTlj3QcWeJZEiHqHIL1hcw5XnZu1ynmj8WzIKmjaYBR64ahpHe1bXiRVkBtkxxEoTF1F3Ul9wxx8EIFQsoBG1GMzUHD2NcANuSlnQQORVqI69dSt7TpKHI0/c6LSAP6mKHFDpGwCgZp/9/3Fu9/e8jrYZIt808HmrdfGaOu29BXKiRgWJZuVrJwRpStFwdD4dG0kxkKMTopYmuuaYPlAPGx8F5CnLMmTcbsj0aeayeCU0LaOtex6RCVS709QhlstabKFbIetrq87IH4QE4wigXGlmMSvCW4/N6gaHFDmX2GSEG+6/SiqRTX/nW28louMIa6iyDQ4s0HKUvCH2rN6UYdbtsPCQ1LR7X0VQ2Evzeg0X4KRs9ipdz0c8yTAjhDORG0ZIpTDBcCAfF3nNGck16cVTvYrLrvKAUeCKjXzSa8Cx8ZoTZIYPLCzVVLlBxxmgINDYadVHimSIiCwvPXy0a53RDgMgdO+vtG04NtcVVBjaQOXeJFT+RxOk5FnMIhA8AJTjilbbTvWE+vxwv3sfAVL2zNw6qyGQQ1kQBEX2kR2GQGeyxZf/VRxgiL9L7fMrEKg/fwHG2SoRRMZUqKJ+Wy2kOPLVeXgQ+T/zjztzcbrrmyDaovxSm+cR8lZJ6XrRn2Y5AoXGdopiJz33y7VXmJ8bZ7J4YRzwYl2ztT1W4TzVzP5bU3zhGZSwIgoZg+g2rwrOHnDlzMcM
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adb25f94-f5ab-4287-3411-08db4caab027
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 14:20:18.8007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQZr/k7R6AyZzZidm+RUmOpMW2j9bMqix0Cq6WjcoHIFPS8vXDfPxuIYPDOgziUWvupDLXH+6Qm1JyQivsReCpmaRCTIgS5fNaPmcOd3q0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6284
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_10,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305040117
X-Proofpoint-GUID: 65Sz383riQWgsMhrf0BQykIN6b5XEvKp
X-Proofpoint-ORIG-GUID: 65Sz383riQWgsMhrf0BQykIN6b5XEvKp
Subject: [virtio-dev] Re: [PATCH v16 01/11] content: Add vq index text

Parav Pandit <parav@nvidia.com> writes:

> Introduce vq index and its range so that subsequent patches can refer
> to it.
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>

Reviewed-by: David Edmondson <david.edmondson@oracle.com>

> ---
> changelog:
> v15->v16:
> - rewrote for better reading
> v12->v13:
> - avoid virtqueue -> vq abbreviation
> - removed Cornelia's reviewed-by due to vq abbreviation change
> v11->v12:
> - renamed 'number' to 'index'
> v9->v10:
> - added braces around vq number wording
> - added vqn as another term for vq number
> v8->v9:
> - added inclusive when describing the vq number range
> - skipped comment to put virtqueue number wording first because we
>   prefer to use shorter vq number as much as possible
> v5->v6:
> - moved description close to introduction, it was in middle of
>   queue data transfer description
> v2->v3:
> - new patch
> ---
>  content.tex | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/content.tex b/content.tex
> index cff548a..9b694f2 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -298,6 +298,10 @@ \section{Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Virtqueues}
>  virtqueues\footnote{For example, the simplest network device has one virtqueue for
>  transmit and one for receive.}.
>  
> +A virtio device can have maximum of 65536 virtqueues. Each virtqueue is
> +identified by a virtqueue index. A virtqueue index has a value in the
> +range of 0 to 65535.
> +
>  Driver makes requests available to device by adding
>  an available buffer to the queue, i.e., adding a buffer
>  describing the request to a virtqueue, and optionally triggering
> -- 
> 2.26.2
-- 
Walking upside down in the sky, between the satellites passing by, I'm looking.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

