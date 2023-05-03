Return-Path: <virtio-dev-return-12506-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 295ECC77B7F
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 10:40:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6CC61157EE6
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 10:40:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 620B09866B0
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 10:40:03 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 56812986586; Wed,  3 May 2023 10:40:03 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3FCE6986587;
	Wed,  3 May 2023 10:39:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxWC7GrnM86Zpm12ohptS/EqMgOwkpL38yx4U8BTJGaxOnTgEmuD308xLvRAPnyibW7U/fPkeC0rpQwr2AJTkdUy5FLiY4vkoKyA/r6LcTs31PUVd6TFTq5EyJZ0F66DPhfPmH4S7SYqQntUIRXIwWZVCvvYkBB/jtI+BZnx9+2YgZ/aq5rc42Mln0ODO35P482gaoTturkt5yrLJ8Lo8Ry7S4rOvg8wL3Ud2o6qlvQ0kN7CZXGOIac2Rx314nQ290iNVvyf5gUjMREUImLuzTU64Xhgj74OQjGbvFOi21XxtYXFDubdYVcCUYLFeLAnDAcQFmDbP+Jtv0ZTcXwDKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KM3c+MUpeSRYCoIPb1Entjv0Ts7CLqV1QN2NlY3Flfg=;
 b=BkViHr26g0AhUzl/zQIlYjEiAoS0e4qHayweuZs4f539USUkKylAbJgdfWwCFjs1p6654P7XTsEWilQ057mCLW5ncEBVqAS7s8uZFM7VLIrxB9X/qTIuMiSp5RY2UJ6UGiI9z6dX+Q4qvnohJ8jSRUodkdtCH8Acq065oE/Ibir3MHYk6L55u5kUAO5W/hieoYrCvxl4YxiETC657Soa+Z4zjJ/N161S/4KxF8nMMiUh9meog1leNavbz44DQp7CNvu3OlpqWgSBF/WR/HsH20kJlQZ840788KLCeY6r+q9NufsvXB8xCmrIzV+zVgCyw7Do0ETkUXBtg13pZf7x5g==
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
In-Reply-To: <20230428041949.411221-2-parav@nvidia.com>
References: <20230428041949.411221-1-parav@nvidia.com>
 <20230428041949.411221-2-parav@nvidia.com>
Date: Wed, 03 May 2023 11:34:44 +0100
Message-ID: <m2lei5vh2z.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0041.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::19) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|DM6PR10MB4395:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e6aae7b-9d40-4fcb-4f3b-08db4bc205da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	OPOVOp/x3SOEbBdR/C0lrzY12CMM5XrnhK3pntqXfmtXPt7W61GVhkQe41eN9MvA46rnJkfUknQxXXDqvV1+K5FK4e6I0WAz2thusIe6Eetv1nJ4PHIScRDuujNdZ/eGwGVof7jW6UCKc7v97Dvi4xULYv6JUuExMcof8d+T2P8sRZYw+jbMkSS70OqxoJqTVrb/47ZQBxyW76x2MXRhMCQubEyJV56rRwoZXP/H0eAstLqetuKl8a9Hiup0NIWYZRAGiQAt6XmpB2/V/rkuFDdEaqCEQ/2UINzxYflp6ylreuvZTLLtB3K269bB7cLPW1QL0ZxrUIWtW1MIRFuZEvc6qRwxdf0gtaU7TupgyjbVUOvt2QHTxC9MY1B7n/orazkjmrgFWRyD03VQDwRw2+iQpfYFbn/FUuHKLbPTnKY6CTwyZ6F23B4vxKJGifpi7JYu++Lt5YkBN/8vEVx+k0rNAakHKK2MDc8JZmDa2Tx+IqPvBaZKQL/r486lwssh1/uLaWyjrwHLOemLAEI88HTEyiyxb3wG3KTi34UVVdw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4926.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(136003)(366004)(396003)(451199021)(6512007)(26005)(6506007)(478600001)(2616005)(6666004)(4326008)(66556008)(66476007)(316002)(41300700001)(66946007)(186003)(83380400001)(966005)(6486002)(66899021)(8936002)(5660300002)(2906002)(38100700002)(44832011)(8676002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?MGrGe5IoRhdoF/0MOlgmiHDtfu2Y+D8lt5zoOiMy0Sf0dZIQCmPoYMq/vTiA?=
 =?us-ascii?Q?qJknOj8d3RyINgKCnHvNYm4nHiUD+lze/+Ax09FaM+XhPhIJvIqHMErpxsZi?=
 =?us-ascii?Q?/t+uzTXorR1mB4rosRsjqkmCXCGTETZBOnbTlm/7nGA8tLqt2AZQ4DJCCTIc?=
 =?us-ascii?Q?dk2bLxLJt+KylgeGG/ljg0MgMnRG6mP+CwsAshxFCcruBl4BaLl2Pano4Vn0?=
 =?us-ascii?Q?bqkBuioqZbOyvMXQjoDSowBXkJorUEr+d/UenBP5pJx5BQB6MGaDLv2zE5Hp?=
 =?us-ascii?Q?+8+eKAxifrALAgoNuCxkDDn70F5TQBfn3dAy2M12MFcVN/PIqbxjtF46XNpw?=
 =?us-ascii?Q?XhIYw64WZ4lDNQEtWwtD08t88WPfIn1R6QnUbz+OFBz/W4Q7fUzMqllsee8d?=
 =?us-ascii?Q?K3T8GFv+m8D7siIVAyOELdfd+jEGyf8b4RMAO+zZMGP6bQCtpq0AuXfdEuMX?=
 =?us-ascii?Q?C9DxFBpiZp0vwKAtuCaIXSDm9aSmeFzcFqTH4j+XgaP0A0X4sozKoXPUpFNk?=
 =?us-ascii?Q?c+gnPara2bIVVf6MDV2GSogKN8kHICeaVM+F6Gd5yJOXehJfIJ9roxggsW6R?=
 =?us-ascii?Q?ESokpRTjM3AduTBpi6v3jkizwjiQwtMj7Wiu/KMzwkRRYTArlUL37VnWNU3I?=
 =?us-ascii?Q?wEP35rkRtPQRN//Q+1vEQFJKoKkTX9g7/2oK1SRM9NmrgBZH+QfJRuN07+lU?=
 =?us-ascii?Q?mGssybMKutxG/WH8x3789vHNbhhYGGLfKrvHfXaXnmjlm0fkjJ78YVO1xyFG?=
 =?us-ascii?Q?JmxEle6jaOSxGhg2TKWRO3DlRJSBtJaeVMiU/eMwlKsai9HMdjIf3RQB9Q6r?=
 =?us-ascii?Q?/oeHLB+lIUV+GaEgu6VgJGDwAfm5QDG0zCqGZsWjOMdvIeOb6GPopH9K5EsE?=
 =?us-ascii?Q?oeKReowkhx8yXMcDPuomh73S287P4/3wsIIIQG5xiP579WcDO9xPMQgb905k?=
 =?us-ascii?Q?A3WXlHW3P/6u3ZzvgDdvrgfCvkNdVbxfR/cpyyuLk8sTjTFlv7UyRblBp0Mi?=
 =?us-ascii?Q?dcWCoOtq5S5pjwc1USVzUC2QqUrwTxDZZLoiGmFlBuFxGZUVEzJXgrs1yzL0?=
 =?us-ascii?Q?xgfHn1tiPrLtODk9EKapWfB2XxzJsQ5n0WXpV5ARi62CC95du83omyb1UW0T?=
 =?us-ascii?Q?pGfh2KpkiKYuWNwtviaFezGsYVb7Z7USCRXLIhyQWUbLe5pi1hlB6SyMmWXi?=
 =?us-ascii?Q?rKuJ6ureVkMeH6nQxAvpiay7HctmE0eVITJAiPsTfntckI0HkUUVLDPPn3s6?=
 =?us-ascii?Q?raeNpW94T7ItdGcm4N6T7bmps4gStBPLD4nvuBlNkXTNX6jqetJKvNpQT2dj?=
 =?us-ascii?Q?565L1xPkdhtmZacomx1BL8omS9CeWNgnyIDnIX43CdojNKUQ0nyHpUajvtpg?=
 =?us-ascii?Q?ryjkYpA4vbZL5CwARhgEwKX25c2jVYhsWB4BB6MnCX2OrdAZ2g6wTnwGTkl2?=
 =?us-ascii?Q?T2orJ+QAZrfw2caCbZPX65iZHqIWZKpB7LI79i9loYh2VatQ9Nt4wPgYChL/?=
 =?us-ascii?Q?tRf/MxDu19HPoP3fLK273Bs1nts0ENLe+A3jMcsVQhzI+UR+N7xchlouYL2+?=
 =?us-ascii?Q?ELs4Z9vGI73kfab8ce8ljkLCthkhmDeSMr87hAes58A/LgNr2Ss3uaGIIv2S?=
 =?us-ascii?Q?wQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	BkEXr1Plsk8AWgT8++LysPUWO3rArWuQ6MvlqZzcGtFhhUUr7smoMAVKh35OqiYLJzbXDvKHLECpMtQvs610MBnyBBCTLLdIClogyA4D1MdB/Q2DU5pjyvR1TTZC7jkyoGmNT9GZPCZ4YZ9JMuE/H9WAaRLSIvaycvkUkMaRld/FpZak7nz8MG4PXFaNn0nymffGM0KB36IJHosk5e0qEHC2Ib+UDkRZSpsbJJY+eEYc/tES+pEFdgONFx+lgS+V5DF7Ry6KGx0fQMfZ/MxXRGxIHMbMGEBo/Zluav88OWGOUthjkZR2JsjeUHn25jjTK0DsqNadwlV3rq2gPykbl5NaVoTvFsTcdpEaN4J+pzIS0tVumiJu8ya57JGcr2qcaZ6fT4G3X1aCZDjvAngYaV5br8AmRlPjlGhsGvfCUWJskypNQbsLQ2ZFRc3r5xcR60zGbpnGiMcoc637l6mWUmoXhq79nV3M2/QlPQ0WIE9hACtUOP4wzfsxwa6uZO+UvAAlqfxipAA5S5ZLszxUjZI1tFw7s0pGHlN5VqPcDKmoIkf4RDdwb5EISa64BGjmgSPHcmhzFSkuxZoCrzRFOW+kcN1HmC9iaoWFSPjWEvoddgJ+3b4u48NhnE2SY6IGTkjtQdb+RQEL4+wZ+LuNZtO9Xd+cI5iZc3x9fUFlvDdgp2XSt2gf0qq1ttrGSUZ0Ejc+MSzpgATyFhWUA6ZBaNGNB93Sbk7kfRi/Ru0ObAaWpNb3gKkNLsW9jQNz/3avcIbz3I0IUuzM9xKMOxi+O4foHN9ET8qxsuVoOqWmHTiXW+GbpxgAzo5VxgltE4SmQCsDwCs3P67Fc4LT8qPU+TAPBR9H/UQExDtQrvJhXA4Q2nVGgB8ioQCCJ/HsZUP1
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e6aae7b-9d40-4fcb-4f3b-08db4bc205da
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 10:34:49.9385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mwFRIE1HnoYIfYhcgki2QJdtVuwx2Epp7fleJwDNIZjroi+4+H6UgifFRUlm9iSFcGxI2TRl5hJ6mW+yDnadOIOmDnX5JKxMw2uZaAlu4Ck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4395
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_06,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305030088
X-Proofpoint-GUID: DFS29-lveFpex7k-Vcc2VfExvkJf2i1q
X-Proofpoint-ORIG-GUID: DFS29-lveFpex7k-Vcc2VfExvkJf2i1q
Subject: Re: [virtio-dev] [PATCH v15 01/11] content: Add vq index text

Parav Pandit <parav@nvidia.com> writes:

> Introduce vq index and its range so that subsequent patches can refer
> to it.
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
> changelog:
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
>  content.tex | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/content.tex b/content.tex
> index cff548a..43be58b 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -298,6 +298,9 @@ \section{Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Virtqueues}
>  virtqueues\footnote{For example, the simplest network device has one virtqueue for
>  transmit and one for receive.}.
>  
> +Each virtqueue is identified by a virtqueue index; virtqueue index range is
> +from 0 to 65535 inclusive.
> +

The range is a property of the index, so generally we would say
"a virtqueue index's range", but that feels a bit odd.

How about avoiding the problem with something like "virtqueue indexes
range from 0 to 65535 inclusive".

>  Driver makes requests available to device by adding
>  an available buffer to the queue, i.e., adding a buffer
>  describing the request to a virtqueue, and optionally triggering
> -- 
> 2.26.2
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
-- 
You know your green from your red.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

