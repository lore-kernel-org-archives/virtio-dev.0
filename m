Return-Path: <virtio-dev-return-11815-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E0CC6FD18
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 14:07:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6F0604434D
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 14:07:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 599049863E5
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 14:07:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4E1AF98637D; Tue, 28 Mar 2023 14:07:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3DBC798638E;
	Tue, 28 Mar 2023 14:07:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSHyYRjttt7VZxwysrs5ac9Ez7st7+Tq9TsekkJwyzip6c25PLPQbEOuXxRI4mjLzl5lNkjoV/aUjmuFHSK/TdoRfC+Z5wmSxaiB3z0BuagkKjQgdGlZhAsRHZikWW3QPN+PnuQJD3F9gzhJ0xWHhBB0kGoXvkquNplmHdnLtyezXQyhc1KjNTfLI7ODXGkGL0yh/RmgVB0FNStgGCsw8NZHP9b9ozyBZhHt/SqYy2LlgRSFqi/yUluFgkvPgmcEuJHi0OOJ5l1jnEa2LcM1HuR08Q/0MlMQD+zhrskuUXAdxeLUZrMHyK8DtVYt4DmaM8NAslzXhfw0b/TA45pYsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgReX0X9vv0TOuEwM23jtf9FczHugH7C+gtuOGOzqMQ=;
 b=nLHkZejOj4jl4GYV+VPkXvceGX5OtWhxI6AvjFrkK/SR2O2Ob6tWu9jzCkJVo9Rpwe6vd5iL5PdaHEWKME+NMUBypNJPacmXkBP+Oy+Yk22gAETOcfoMZAwwvcpUL2Jv2ZbS5Pd1D1mRDHW1Wj2OxlJF5V/OELOyW2p9T64TcDq57Il0lucbTJ8cFS5e3BX2XtaTzFptyHjnvXkkq+qUOZf6MmqGm51gTuTfczrayJTS1C/C5wq8o7see3xhqCqTyNH4As/GTRVRtPmrRCPP9+0WXFyYu4I/nXCOR1XNIUPyQHEkRUa+CcEZyyT4TjfLdMJCsrMTGRWobD1MSotJDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
From: David Edmondson <david.edmondson@oracle.com>
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com,
        virtio-dev@lists.oasis-open.org, pasic@linux.ibm.com,
        cohuck@redhat.com
Cc: sgarzare@redhat.com, virtio-comment@lists.oasis-open.org,
        shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230327235936.414196-6-parav@nvidia.com>
References: <20230327235936.414196-1-parav@nvidia.com>
 <20230327235936.414196-6-parav@nvidia.com>
Date: Tue, 28 Mar 2023 15:07:18 +0100
Message-ID: <m2wn31as15.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0478.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::15) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|MN2PR10MB4144:EE_
X-MS-Office365-Filtering-Correlation-Id: aece0ef7-70c8-4f8d-aaf3-08db2f95c09b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	VX3dCSk7MPZqOKBbSqpfG5NbaC+BJxTbd26f89UH092S1+w0PIE8nSwcHbCSQLGhRSKhYPdm4spxGp3FfajF+IK75G5RAiIG7W2jYUdP0ldo58mlYtHnZPCQUgc5zhQ1YjASha0bjAPUtIauJAxujAOiORIKf89DZHxi8FyiETnf3fujbyEIDxZNRVby8eZDTsVoTWGrNk3QojrBYcbiCVht6fTACRCT9tqL3O4Y5yL33uu8tt1srWa2kAmYLfdhgixwIexRcwIv2a+AjrPu3DDOyWaDuy6Lq4Iou50rpRW+QKJ2xxW/slfRWOX9rd7OUC1pdkPTiWdMPHqsWDll4ab9rTbMpGM+E+tr1Lp9AWeI7q84qmxGgzjYYygiubxEXCnAlhFvi9Pn6OAZ6VvIETiAwuCj0w6OdZWW42fRvr7M1ixV7b5Pc+tCjlwItuSnYpLP2+Qcu+LpKAUftXD0qqIGrIqFjYKBH/HiM9CoLQamhMFeWK9Qvkol4IuQMFnvsBKHr+QQR/7jEQ+3gWFY3f+sZI6IkX73GbIEqo1cJe5TW1209Cxzn6+etOU16twGSU8zbUZOzw2Oaso1upmaig==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4926.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199021)(26005)(6512007)(6506007)(41300700001)(186003)(6666004)(66899021)(966005)(6486002)(83380400001)(2616005)(478600001)(316002)(38100700002)(4326008)(44832011)(66476007)(66946007)(66556008)(8676002)(2906002)(36756003)(86362001)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?42iexa1Xlo02H4UDXskfLhWp76voMJSh0JlHk8/gsjjab0aXiTukFCwHZ4Kb?=
 =?us-ascii?Q?dsJiJi2blggEPQvVU6BvWqXftXpuml6Exqkm73kFQrfJcx4I/KVjoExQx4Po?=
 =?us-ascii?Q?Wonu1wkdRh5srrPY/kU4OocjPxHCtO/hc8NrC7aMu68URmKSVro2w6BhBCmd?=
 =?us-ascii?Q?jMr5tIyNi11+0sv9v88Ep0WFWX10MwigNum9uqh3D/q9rax8yvCH8RqcApXt?=
 =?us-ascii?Q?YHOLm8JpURHhjHhLeRo/IWjKmUmme+v7FgQwRxNYi2MAchKTuqQU1yQnneMs?=
 =?us-ascii?Q?SgqxUBfnvQt28qI343WlSLLUPUUeZbMcP9w5lftR1VIIQgC3UFDDK1jxFtU9?=
 =?us-ascii?Q?3mtK0vFmwKu2NgtZStaqDEkYTi5Cs0w8HYJ5colE1HjHdGyURX09FjCv4Qni?=
 =?us-ascii?Q?rIp5mryy856o2lBFxrZmYa1byGtU24DsFaqYF/hz4NTdaO+vXMFAWfu7Gtuw?=
 =?us-ascii?Q?2jLFAman9sPUGBDmDU4qwfRavG24BeLAxvWon3pNEohlFp37LqYKSqIQuUpN?=
 =?us-ascii?Q?tfHSIll4HYensmeYXufUrpInxV6uEqOcAmuyh3PsXD2lBl0GiP5Oesr65ArR?=
 =?us-ascii?Q?BJMBMjsXXgiO/ZQp3oLgSAv+I5Hki4JMvxWmzRZTlOZTXeOzV8jStMq/xRFB?=
 =?us-ascii?Q?nBrcAU5iX3VuTd5NahHeAb+Fl6/Cac8JmTC+K+BbxZ3mDKrT7NTqcGxOt2ep?=
 =?us-ascii?Q?U84HW9URJ506Q/vzTibEjbMxa/YQ7NXj4drSjHUw3fQYzDBH8vHXEEMUQLFp?=
 =?us-ascii?Q?hIz4AhHF4JS1jRtLij+5I+vUoMxG4rf4SwydI7wTJP9S+lni9g2IMiZn70s+?=
 =?us-ascii?Q?kcKe1gWdtId148obWIbt2wRS8lK6vPMRmAxg34kECmog5aMUkpz3cTDPfVpb?=
 =?us-ascii?Q?FlJhuMdrOj5H2R8zyRlwjKn7CS6cesC5Hk43Uk60qIYAMbvnxD2BtQ6mFW8D?=
 =?us-ascii?Q?LWIWiaFDi3KusJiB5ONRsDjTqJ4i4pimlPMTYmvF6VBkeWoh/RcMRiHlLJvm?=
 =?us-ascii?Q?98WLlE/Zv/4emoAUXNOMpc9g5J460wm3U5vyWr2NI/t5HkvOrJ71bRCQuzAV?=
 =?us-ascii?Q?H9MkOeQtfXGe9HubN35zTRF4RgY0VqwZCiLCa5vb4IK8syQsqsTk4TEiYJTe?=
 =?us-ascii?Q?lxr/lKg6CTHSuuMK0jr0Ch7j/zOzfXBoufGEWW7cSc+oJ9R23gw4mT6XUzGu?=
 =?us-ascii?Q?TObhUviA3rrwChh5si9Lxq+xN5kh1LjvEO6P9A/LbQnpOcRPE9802OtKBg8o?=
 =?us-ascii?Q?v7CxpIE1wSgZCn0ylU6NvHWlA6IcZKRNrFvzx6KpZKCCevEV5+LsEmyeJLUj?=
 =?us-ascii?Q?ccmA/wfKdm73ImXWQNvn/5jJmcNVSj0mokBiQbr8Ie2DJN3Eldk8ZUSsardt?=
 =?us-ascii?Q?GNSSYskZ+sVtn20ZufPJuqjFUJ84QVs8SZarwGO/QnyIi1AE2ycHRVXQD1Sb?=
 =?us-ascii?Q?WRS0xF58m9yOjc3KO+i4d/u1mW8ItEeK2yYVTgeY6pSlKsV/T1pqrhOd6/fR?=
 =?us-ascii?Q?AUYKwGbeVUQwsQEFvCsqskH2K8NCM+tTdT4CKhrRzn11bwAB96uPuxDlh9z1?=
 =?us-ascii?Q?X+MG8vqmByE8y8Ssk8fFvCkQTbAX8c8SKeOKJvLBFwoVSl4czweiXu/qjwTM?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ESacfuJ6COiP9MX2XqzRs76uk0Nhof8Bn9maYQoEwY/ATw+jipNzC5TB67bPlvhhItTBvT0lihEj/UI0tceN977pt47obxiY+6tcfWolP/S7swzT0KRkH3W5spKvbJfRavdK/mUKcbcfrPiANg05M5B+7HeRre9VgZknPOSoCMm+P5I0tAd59ok6X+HwVIM1EdO5DIkaCmEmPXKM76vXWzdmnB2ZIATDDOVRLTbfwcakO2Z18A9kmTsRHXXdfZ/07B7aBHZgcWruTPZsGyr9+UJAMMIgg71P/rgcCka4vle/LX1jzXcEs+8PFLXndM4TpgYXwEfz6ZR9pnuYnjWaLA8Bf77FkKEO+eg6mz3A7PcaC515jZw43Ypqqg0FG+kMlPIPrEmKivZAC5apgl0D4t+F5AYDthnj9qdJZYavnx1x+dKM7PQDlCS62+Ks+KFbQJeP7tBeokZTtd9UcXtZmkUgpNohOP2jzaVLsehQrlV4w36HKo7vHB5bBabWkSLTrHTXN8gVCPnn7Nct9bUEYJEZ3sd4ZqH81AsXt4Xsj2CXW7nP2Cbgd1X3L5tUG4gaQ/PUw975rRyMDszRqvB5kTE98JxoiguRMFevh0l1mdriDValKCHrCXl91EO8xMgHS7CqcLGr3FoNE1IaELc2Mat8MfevQtlY0rVc1CEfJ0lxZW2+4cn8xbhi7BeCRk2n3Mzr1x7t9yS1DfpbOBfn+X/Z1XQifaPXW7II9jZDshzNnPQAzipW1W4jxemeWmhddROdpLGx4nLFKDQlx1deyoPY6RW5TtUyHnucdn01vZHU/AwadqiYyXcPUH0YJhMisXJhsnB1h0y2PyYkY3Jq3HTsdjAWmMriD0g+JxG7u7B4RC5J/XdeBHPeyEO5U6Sn
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aece0ef7-70c8-4f8d-aaf3-08db2f95c09b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 14:07:23.3120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MLxeBixwWctzdeH4OLH9ZqBD5GhpRsgh/m5WxAuPqEJE4TJr8rI3k9Li7DRF/d4fiQc8e4BAdpaQJZI3Ax/KFri9g1tbNZ6/PoH9qE0BsVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4144
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303280111
X-Proofpoint-ORIG-GUID: DrPA4Q0ZMPt_ZQhuQPlQMEa63mCkhT4T
X-Proofpoint-GUID: DrPA4Q0ZMPt_ZQhuQPlQMEa63mCkhT4T
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v8 5/8] transport-ccw: Rename queue
 depth/size to other transports

Parav Pandit <parav@nvidia.com> writes:

> max_num field reflects the maximum queue size/depth. Hence align name of
> this field with similar field in PCI and MMIO transport to
> max_queue_size.
> Similarly rename 'num' to 'size'.
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
> Signed-off-by: Parav Pandit <parav@nvidia.com>
>
> ---
> v3->v4:
> - moved note to comment
> ---
>  transport-ccw.tex | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/transport-ccw.tex b/transport-ccw.tex
> index c492cb9..b4bc83b 100644
> --- a/transport-ccw.tex
> +++ b/transport-ccw.tex
> @@ -237,12 +237,12 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
>  \begin{lstlisting}
>  struct vq_config_block {
>          be16 index;
> -        be16 max_num;
> +        be16 max_queue_size; /* Previously named as max_num */

"named as" doesn't feel like typical language use - you can remove "as",
though I'd be inclined to use some kind of decoration for the name:

/* Previously named 'max_num'. */

>  };
>  \end{lstlisting}
>  
>  The requested number of buffers for queue \field{index} is returned in
> -\field{max_num}.
> +\field{max_queue_size}.
>  
>  Afterwards, CCW_CMD_SET_VQ is issued by the driver to inform the
>  device about the location used for its queue. The transmitted
> @@ -253,7 +253,7 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
>          be64 desc;
>          be32 res0;
>          be16 index;
> -        be16 num;
> +        be16 size; /* Previously named as num */
>          be64 driver;
>          be64 device;
>  };
> @@ -262,7 +262,8 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
>  \field{desc}, \field{driver} and \field{device} contain the guest
>  addresses for the descriptor area,
>  available area and used area for queue \field{index}, respectively. The actual
> -virtqueue size (number of allocated buffers) is transmitted in \field{num}.
> +virtqueue size (number of allocated buffers) is transmitted in
> +\field{size}.
>  
>  \devicenormative{\paragraph}{Configuring a Virtqueue}{Virtio Transport Options / Virtio over channel I/O / Device Initialization / Configuring a Virtqueue}
>  
> @@ -278,11 +279,12 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
>          be64 queue;
>          be32 align;
>          be16 index;
> -        be16 num;
> +        be16 size; /* Previously named as num */
>  };
>  \end{lstlisting}
>  
> -\field{queue} contains the guest address for queue \field{index}, \field{num} the number of buffers
> +\field{queue} contains the guest address for queue \field{index},
> +\field{size} the number of buffers
>  and \field{align} the alignment. The queue layout follows \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Legacy Interfaces: A Note on Virtqueue Layout}~\nameref{sec:Basic Facilities of a Virtio Device / Virtqueues / Legacy Interfaces: A Note on Virtqueue Layout}.
>  
>  \subsubsection{Communicating Status Information}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Communicating Status Information}
> -- 
> 2.26.2
>
>
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
>
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
>
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/
-- 
Slow me down, it's getting away from me.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

