Return-Path: <virtio-dev-return-12549-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4727CC7EE21
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 14:28:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AE9383F54D
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 14:28:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A2CF99866BC
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 14:28:43 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 97FBE9866B1; Thu,  4 May 2023 14:28:43 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 86A1F9866B4;
	Thu,  4 May 2023 14:28:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMW2eohW0Z0Ajp/2tnPrUiuUOUb4KBFQdso/UNcIlJ5JCarp/0A+pHrpat//SmB/3siSWgZSQFyGUwfnQxpEhzrZnk2qJpYNDI2FAWGgetxX1s0INSpx1RIQXnzSJWDl8j5VUOGFZgVbUJLkigUhcGUU10BZVD5Cp+W17GaL82K6R0438aLyB2tsNQ0s1LowOZxEi40ep3c7j1jIP6zEYpIivt3ikXup92SKnHQCmShvBU4h+mnuSmym7C0wsm8s5gtj0bBo3uLFOAXjlaKmkFjqDf4efOrVg6e22iHhW0aSti//9J8cgkQrDN1jNmsbWtTg18EEz7hx2djFpd3RrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1rEOLVHG3CjowLHxiOncdFBXMoSq60Mh/9oAx8Nkkw=;
 b=JPARAA6PR3+Tj3HobKH4froTtaMKxmeZ0u8Yjt/KYhGv7EWBknZR73tHgD7igtbqvdk2C++8lMfcYeOdCiQtQV8nU9feAsPWg1ADsOAT0OLWgiJsLjeb7ECVFVqtbGz0PIPn2VtZmWqRDtYTAsYfMHwoYLZAcR8vZ9x5Y57FK1cvTRTDiz3i1q+uCkiZC4lspauqy+U+yeSABCWJ/YOJNIMY6GlIRhVMm7i2db5CGkbvVF+2VnveWNrREvIyL7cemfODXcghZQCzY+suGnnCGSyt9W4O9SyLSUaMeyrvvtkTcxU/IiCLJDz7dYM7cYJuwsrq6GBCLKedEA6DS3WDwQ==
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
In-Reply-To: <20230504022959.547025-5-parav@nvidia.com>
References: <20230504022959.547025-1-parav@nvidia.com>
 <20230504022959.547025-5-parav@nvidia.com>
Date: Thu, 04 May 2023 15:28:30 +0100
Message-ID: <m2wn1o41dd.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0696.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::10) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|SN7PR10MB7073:EE_
X-MS-Office365-Filtering-Correlation-Id: 70ed35a4-8e72-44e4-49b4-08db4cabd861
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UdP5Eqwkq5Irz7e8kgEuXWTYBBo+HYnw/fum40sARbOXmWsIkHRa8wqVClCVH8v8Hz56EtM6HAhuKJ2lvlZfUOfHJtUc2RDzTF6vO9snTsa9gBcV9rnve409L3WGpVMhUUl/kSIWp8A5lvf78LNUnTEOUT1KUQjEJJLCZasstOHvYRb/YNngBVis/OSE9XkYshJHRCA2SQnnSAYwUhHYv3cCWSyRJMj41PNgyn7kD+KdM4++SMEmTgZxKBtVVDnpcILBRC308W9zZNXkrZ6JnXHJUQYL+3WC8j09Ea/XRM6spjHsWHGucaD91DViaxFS/esekL4dmzbkWQqoEeKrdfXllS5udte950nxiJAA60hJddj1QxoUNNTbtOc35qc3Px18yTqZarMjmK8YcYnw0alzPsGjOKQOO2rkHKDpiwpeyO4mKInf7GZnAETvfaPDILrAudXR/GIyl5mq3T7q/bnv9WMaR/TFSICWgrzrmGRXI4ZyxcnfKXoYQGafUnw8cxIY1h4E/aKKbAircZnkHDNF/ipUN25vEJlkiltrySI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4926.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(83380400001)(8936002)(38100700002)(41300700001)(26005)(2616005)(86362001)(6506007)(6512007)(44832011)(5660300002)(8676002)(186003)(478600001)(2906002)(36756003)(66556008)(316002)(66946007)(4326008)(66476007)(966005)(6666004)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wI3iUb/Cl2fwM+GXgsoWOBbz7mCl6FVE4p3pT3LMByXMzCeWvvF+VMY3Xw/c?=
 =?us-ascii?Q?FJLIn8+KgwUkT0ZAfAofDA1sQuNUgS2JE/lzdA6DHW0Hw8gtsiydH66xSTmj?=
 =?us-ascii?Q?D9TSGz7aSchudavPIpx9pjUAJgUltx0qg6quBQM/6hnhKoGrTHGrxieeXn95?=
 =?us-ascii?Q?SxrDZj/j0/Bmg0UoObjJZXfT0yna7OOVLkyGLiYfa6D5c3ta10CLWgstSjSb?=
 =?us-ascii?Q?MbF4Wk6nprFBlFjSYx1tRKiU+mpEUAZTaisQPlyXXFZn7b6VUIwrY5XRWyXv?=
 =?us-ascii?Q?4O76H48nJmxN3M8EQrNpeyvBqQ+XSkZswmF4dfnmrxx8TMy7X/dO4qSZobNA?=
 =?us-ascii?Q?UlqBjumv8YdPWRUBWVGz3Qu5aukar0hAWiQNHB7RK8hETuH806U2LO3NbISL?=
 =?us-ascii?Q?EVEesi4T8MDE4Oa+eqOyB0ykDkpNKsrTuwhb25vCLS27pRNik0+jhCLv8TxN?=
 =?us-ascii?Q?rtV9dd0WQuQPvDbSzbyq67H68Xx9M3/zPdjCqqoBMqFRF7vRQGYfBCia4iRj?=
 =?us-ascii?Q?jld8YY+dVhR5TPiAlfg5bYHqC/K3wRhfTq/fLMu0dyQZQGhabp+Wm9I77T8H?=
 =?us-ascii?Q?xwFV98Jaiv87r9M4ETA6PP5qLLC8ukk50SSU+B6abba2LUSqcQL9Va4B2Gsb?=
 =?us-ascii?Q?66TywehoSlBF5SBPdWnrT4Xu3RsJ9V1Ci87a05QNv1HzkK+iWT8AGVC8gNsR?=
 =?us-ascii?Q?qhCkm3+3ywC9Ukkj+oONW1aGIVcYkajDnlhEz+SagHM2YKWQbe5H+e74B6wW?=
 =?us-ascii?Q?mYeZnFEVDTYO+3GutFbSOQZyJ+fBCmDsUTL81ttdqBjuk7e3I+5zDih5N1R5?=
 =?us-ascii?Q?VdpERUGzNkjmuJ1G7Y6tvJI1U+g1NMqoIjRGicfht+SynyY5P0xKLcedeVSs?=
 =?us-ascii?Q?uro4mbCCfn6l8W7CyNVQTda/DAkcQdg9ZW5mKAadmlY+gyKqr7Xa+6H8jpzz?=
 =?us-ascii?Q?SGE38EvUeYLw8QlExDDgKttu3C0PgYpCTcoxV2dzyZsdnXyf8C8i+Tdq8Z41?=
 =?us-ascii?Q?QV3/9o/rkbAwc0abGADWUexaBHC2noleiHegBASX+MpxXvSMZaNipb2mf/WI?=
 =?us-ascii?Q?tmY791WudJrkFdR9FEvvtyT43UnYm4QdB5psSLKkUYCP7z2IfvGvA75KINbP?=
 =?us-ascii?Q?favwAsXkCYP2JBAIMJSR1D7x1ReKRZ3XJ8UJyjuRcdutb7Sba8hgzgT19qJz?=
 =?us-ascii?Q?a//jtX97orhRlrWAiWwdtFAt0hcSoyIdvPyZozDL9oopYhO8J3ZnxGbKgvNO?=
 =?us-ascii?Q?MGZirIwIzOFzPSny1r2d8tJ7BU0jCJ13VBiOtI7FqG25v8E0P6gLW5fcQan2?=
 =?us-ascii?Q?/wmkAazFlaoPBiEw8iL0z+UBNr/1EC4Cx5I7vSqOKQGV4WDDQ54quNkNO8tw?=
 =?us-ascii?Q?ATaOWf0nW2KXsrczE95w37b/db/1iU6xXKySZXi3+i+yAHrji3Nzt5Ex07wr?=
 =?us-ascii?Q?ecuDIvmw+9LcJpOdJ2j4Y0Zkj0wRYiBdMx3XMn3MktcJov5wgb+3qRRsON+o?=
 =?us-ascii?Q?IhDYNWEm50eccDs9LxFk/gwxsPX5HTYBOsf1y0Ciapyrc2QYTjdKQYJJz4wi?=
 =?us-ascii?Q?6DIC0+c7OG9om1h5TXziO8uL1sx9Zke0tqhFiZPzLTquy8yk/AQ7gJhlasKr?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	CpfHKUiQC3HETdZNdRaELHqeZSZhGe53P4D4Jyr/M9QnaWCSAfBjm9OC1erz/RZ2W7Oud1nqcUolJ4jN6okm6aM7ApyZ2zExwkjIySiD3DquweY7L0N8Zw5iXa+g0FMJrCD+nbGE+9YLlLdFwhagmbRC3xnBzvaYbQUlY66Q5Ks7JeOZMeylGoMXimI5kyIsKeKxBbvltxiPyvr/FlRD1nn83Z+M7tL4lBJ3hscKDx8+cNqccifdkc0vVi0k+6talpF2beJlcxnT1dbl2AoSH9c5LesqlUWD/SL4T6WLtbBpEK9ZZy6J88y71yVlHJ4XpyED+lqQjJ/+VlCPFkzlLAfOpcD9nA0JS88DqJkpDkEg7H3qlXzNYohusqVoFE4RAD8RWNgb14ROmlgPn04uOfHR50TsLDgtYMaIVOjws5Z0bZ7h95yROrFDIOX2TrNBFtNU9Y6/rCNjeN1BkwAGyjH3+lxgSF4VFOxcm1wLXEk2Xm8fJzc/2QbN901DyT+Q34jpu42W41jJpYfcA6eoKwc/MF+on7+HXO5SuNj9/V7L0z+KZX+1bQ+us2CoQLHd5FDPMnSDQ3ASAy9hNPhGvGbRNoZONpZ57tSOgyR/sWSCA34FfRqnbeLAOeJHxh07sERq3S6Uap/P1Bo3WhVbOFmFlz7FSh+refRB68LPdRTRdr3pGV0n1oohVeReTJQuChH+8INf3RySBI4HvVirj4FiuD7iV9QFV53zPEkYNTVPcDhXUAvQcUsV9GzuVP37aqHklpSqPUsTOP2NYRq03etLyt9gdeeqPCvWfaSWNJirncPT8Z/ySW1uNw5bPjQlG6w96PNdzCOdV7RqN3bPwz6DOokM0bsC/Cu31P7QI+kWqw8CBVLRQpkb8aPRT9nK
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ed35a4-8e72-44e4-49b4-08db4cabd861
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 14:28:35.7543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mjcHmdBNeiOpf4/z3ImWwKXEMComG49eD++u7XM/4MOy8sNanagGng6LzrfLQuESOYk2SIG66esbRKZ+bqHTa3Ppx4y4Yyk4jErj4P0yfZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7073
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_10,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305040119
X-Proofpoint-GUID: 7d7lAHvaMus5l3Tmvp9LXfAHxD9bfbye
X-Proofpoint-ORIG-GUID: 7d7lAHvaMus5l3Tmvp9LXfAHxD9bfbye
Subject: [virtio-dev] Re: [PATCH v16 04/11] transport-pci: Avoid first vq index reference

Parav Pandit <parav@nvidia.com> writes:

> Drop reference to first virtqueue as it is already
> covered now by the generic section in first patch.
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
> Acked-by: Halil Pasic <pasic@linux.ibm.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>

Reviewed-by: David Edmondson <david.edmondson@oracle.com>

> ---
> changelog:
> v11->v12:
> - drop changes related to vq number
> v9->v10:
> - updated commit log to drop reference to old patch
> v8->v9:
> - reword the sentence to avoid future tense, like rest of the other
>   fields description
> - reword the sentence to avoid multiple verbs use and put -> uses
> - use shorter name 'vq number' instead of 'virtqueue number'
> v7->v8:
> - remove note about first virtqueue number
> - skipped Max's comment to put word 'structure' in same line as its
>   crosses 65 chars limit per line
> - reworded queue_notification data set line, as '=' and vq number
>   wording was odd
> v2->v3:
> - addressed comments from Michael
> - changed vqn to virtqueue number in the Note
> - refer to vqn field instead of virtqueue number
> ---
>  transport-pci.tex | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/transport-pci.tex b/transport-pci.tex
> index aa9842f..cfe3fe2 100644
> --- a/transport-pci.tex
> +++ b/transport-pci.tex
> @@ -1011,7 +1011,7 @@ \subsubsection{Device Initialization}\label{sec:Virtio Transport Options / Virti
>  The driver typically does this as follows, for each virtqueue a device has:
>  
>  \begin{enumerate}
> -\item Write the virtqueue index (first queue is 0) to \field{queue_select}.
> +\item Write the virtqueue index to \field{queue_select}.
>  
>  \item Read the virtqueue size from \field{queue_size}. This controls how big the virtqueue is
>    (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}~\nameref{sec:Basic Facilities of a Virtio Device / Virtqueues}). If this field is 0, the virtqueue does not exist.
> -- 
> 2.26.2
-- 
I'm in a backless dress on a pastel ward that's shining.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

