Return-Path: <virtio-dev-return-12035-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA535C7618D
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Apr 2023 04:15:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0A9D72B078
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Apr 2023 04:15:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F2DBB9865CD
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Apr 2023 04:15:46 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E68BE9865B5; Thu,  6 Apr 2023 04:15:46 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D57E99865B7;
	Thu,  6 Apr 2023 04:15:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMLknHhR/pZmAKq9XrULXoI/XhVClVeSy+O/hyFC+GUdg16NSJVMvPGC84u1PN4AezLpViR6Z2Dq3bft55Pw4ueK2wFD25TAfqS5fhN23EeGxOv/jL01tOdcr+ijSOgTBAu+wQIH4mR6KzJilVbAq0nGmcoSDDBf8T1GyXzhAbc1XI8l7kQaCgyQqOyfwaY/JXL2f90vgA0sIZLPm1GHwNaS9SHYZovIj5STuXElfLdDthDkDq2S8gmCk6UWl2/6HPTrbIm+GLp3nT7pi2/d+i76q+7O70gv3yeTRJK0km0/ngtWOnrjk3kKe/Xx7AHTHuyDs/9rN8B98dQ4cI1Cfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5MRLAAbLoQQE+1bJ8/89SqVIbQ50bnQC3704BllCl0=;
 b=e7p7UjGBicSVRfiNnrCzVlJBmIhymqV/9XzKzn2L5hOLslXne6Yk/xKi5nXvCnHvvgfSn5iwBIYkIpRpyMwXZCq2lmogH5apfu5008wMB1SOE0OVK8hMSQAxeY5YnPrjUQ6YetC4JbfdCyHK831CEDzBDem+XiAGMcvcOhner45iHGWaCzxtgQ523EO94KQLfi/Nf0p/8jiEmgpraLyIe7O0OjxOl7DYZtwbgpmROTO8SFneyz1qjzE4rRjtAjQsuGHY0jOz3wMWjRKA4iQzpHwZpXPg0riLw9ctlslFr7K3xXqKI4C5g3aBhCYqKGXm513havbiAxy5EetUyFqHzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <6e44f7fa-d45c-b590-eab5-b18b424f581f@nvidia.com>
Date: Thu, 6 Apr 2023 00:15:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
 stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
 hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
 Shahaf Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
References: <cover.1680533760.git.mst@redhat.com>
 <71c1c5f86e19651585426160fc4cc15dc2da6ee6.1680533760.git.mst@redhat.com>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <71c1c5f86e19651585426160fc4cc15dc2da6ee6.1680533760.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0200.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::25) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|PH8PR12MB7277:EE_
X-MS-Office365-Filtering-Correlation-Id: 90fc76be-08dc-477c-ee7b-08db36559497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kL6ymb8LaO32VN8/PKvPk208We4IgKuxCTP0WCrlMrHf41ksXpNanE2fi7PIYInNDkeovYeIqvErh1H2aY1ydGh6m2yidso0rQA58o6EbJemXyvm4DxNL7sizicAAt59rzYbA6KAJKoCSLeMtXYenn5VjFLnsmqLwMhyBsbCsPly2dK4X7LyXBUI28p4W9QPphtKu/XgkuB87s676xS3BARXcfo5t3Ri/1F1iLIJWGozG8Y3t/98jrAYCL/VKHkKIew7zse3TUwFZ3JS+wd1PP6yYaJdrB55o6tlEVakRaUEewqv816GyX5eFedlrdKJgxxZBG01Qk7EAhskfrFEbj2NTKb5YvWhyBR0O4W1gFbCUuURXkbPMqa4SudUowM2PLlaMhd4/BDqlAar2RqtH174jZtr42l2dcyzql/R1upO0qqSKjjNRji9hWZUa01/enzFThZcPoHMp/JD/Rut003sItCO5v+tC+2kB/g7tFEeEBSXjmr7WQTzSfoCm3Mankk/T5i2qyLLKuygFJZsWHhSgAoQb+d5Gmozt+GadHZ/9zwKZ53toapzafKdUqzOFMq67EoF42XcZMWuULxUAD0+HxQsog5m5BlMeuLtJ5qiPYueT7borzTuK7E4DOo/QVlqLCEofRhuexllSdjXNrMlSmn6Wkh0cgxUfSd2ff4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(451199021)(6666004)(6486002)(107886003)(36756003)(83380400001)(86362001)(38100700002)(2616005)(53546011)(921005)(6506007)(26005)(6512007)(186003)(2906002)(8676002)(5660300002)(316002)(54906003)(31696002)(31686004)(7416002)(8936002)(41300700001)(4326008)(66476007)(66556008)(66946007)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEp6dWcyYmZ2dGkyNFhqM2szQ1QvUzQvKytnY3NGeDFUOUJQRUhRWFJEV0xr?=
 =?utf-8?B?cjZncThONldJdEhqbWlkU2RzMnNmZjZOb3hpSk8vY1lNQmkvclBPTkdCZllu?=
 =?utf-8?B?L200RUVybllPNkJXamtqUjc1VmFoZEwwVkdtRG1jVE9SV2ZDV1NBbU8wcHl1?=
 =?utf-8?B?d2pBL3dxRk00Qm1iSmdUenYzMG9sNDZEYWhmSjZVeisycGg3M1MwYjdEMENq?=
 =?utf-8?B?MTBjSXNBTDl1cWwwKzFSNkcraXpHT0M1TVIzU0tNeFdkZHBNeE5XN08zZTBs?=
 =?utf-8?B?M3NBVjg0V1BSMlFCS3FEeWpjRCtvNHFTU0dSSXdkaE12bmdEaSt6bk1BS1kv?=
 =?utf-8?B?c2ljaGhLdGIySGZrT0hwc1Y2WW9zMElOZGZaY2lHWUZ4Y2gyeUN5RFBhRldX?=
 =?utf-8?B?KzV1M3FNRVpuNThaNXVZVkJ1amEyY1A4d0lUWkpQd203VnYzcnhLU1lVMm9k?=
 =?utf-8?B?UDZrTkNMMlNHR21LdDhWK01rZkJQMitVbTFnY3FZd09XSXZPYVZNVnV2cVRt?=
 =?utf-8?B?TG56VXhOSzdNMGtTYzJpRGJucUJXcExDOW1lSkF6RS8vd0pyZGMrS0pha0RR?=
 =?utf-8?B?SGJyTFJrUkh4NEhTK2lSTUhXT3pYR0hQSkVvYzRxTGFXSldFcCtxbXhEOFBB?=
 =?utf-8?B?a2hEdWxzQ2hNZDZHVFNnS3NSNkwvdGNGM1psbjJ0MVFTZldZTDhLdmFzdkpr?=
 =?utf-8?B?UkRKY3Z5TVZuc3JyeVlEeFZBaVlvbTlmR3pjT3JGRGFxelJiaGZPMmlzTktI?=
 =?utf-8?B?aDdiUDROeFhIOTBKbEN5am01RmcxVlRwM2d6Zk1RYlJZZVpEQ1V6S1VKRTJV?=
 =?utf-8?B?MDQycENFckVkWHlJMEwwcUtRd0pnL1RvSWFpV1lOcWZHcHQ0WGZ2MU0vZ1Ft?=
 =?utf-8?B?TUZZVXlmOU9vZTZ3cjA3c2JuL29qK2FuY0sxSEsrRW9IV2MvZGVEZEJ6aTZM?=
 =?utf-8?B?WFk0Z0gxQjlKWnZkZDAxMDVIOWE3ejhkb1U4Z3h2Q2d3NDRRS1BGa0dtTllw?=
 =?utf-8?B?MmZuSVcyT2h0THpwOE5UanhBMHkxT0c0ZXFxKzQzNHhDaEpha0N1UjVVQ3Zy?=
 =?utf-8?B?NE0yOENqNG0xSXczaFdtcERGeDRwdVZYNkd0ZDM5L2JBQlFTNFc5SkczaWpS?=
 =?utf-8?B?Q1VINnBBdzJFa3NpMnpHckZhbnBVaG5tYWkvcE9VZG96aTZ3R2pnT2g2S0dM?=
 =?utf-8?B?TEtTUUZ4ZmNDNFhPSFhxMEphOG9NTXExNDZoUVR0K1MwdjlWT0hwNzZyZmFq?=
 =?utf-8?B?Q2x3MUwzWXFnOExvSHJ6Q1hXKytOTzNZTElaSytVbm54TGEvWFpDaTVhM0Vo?=
 =?utf-8?B?UUVZVElsZmJ3b1V6aUZBRVB6WVgzMFg4MldWK09uaXp2SFNTeUFKcFcyTEpU?=
 =?utf-8?B?eFg2Zi81SGdyV1NSR0tjbHpYb2Y2cTVWbHk2bFNJVldYZHpKbVAvMy94NHFw?=
 =?utf-8?B?SkVPV2hBaCtnejZUdW9NT2FnTmtubFZ6eTFvSmdjenBheTR0Ync5cktrOTMy?=
 =?utf-8?B?NDBUb1JPY2lrNXpOOXpVbEFJdU5zOHNkaElFdzQ4Z3RFNk5oOG81RktqYWNB?=
 =?utf-8?B?akNQa2V5bFNKeUFOWDlZNHo0TmdYYUl5T2NGVHdVdTdLR2d5VEk1Kzlkd2hD?=
 =?utf-8?B?VE14NFlZMEJCaGFudC9tSjFZSGNab2Mvay9NdTBNbVVOV3FpbFlucEhqcU45?=
 =?utf-8?B?aVFRNGdhdDlZejFpbXQyVHErckIyWlFScTlvYi9sdGc4Wm5icjlabzdLVVYz?=
 =?utf-8?B?RHRITkxveVd0QlFZclBWRUtQVUxRUG12dWJXWXJ0MVZ0R3lTd1BIbTJheGM4?=
 =?utf-8?B?Q0RXTVRaZmZObGRzMzlBN3lkai8yZ1ovMWJqNDJ0QUJuc2FsRGUrQ3VQeWFC?=
 =?utf-8?B?T3E5RGdodmZnbWxoeEdaKzZOdmdhU1RyazJXWEh5WFZXbk5PM3BSNTd6aEgz?=
 =?utf-8?B?WGt2QkgvVTlCclk3dmlTWjdXYzRYQkR4UTFldFFRMWdjU0Y0a3dsQVhkTzNv?=
 =?utf-8?B?OWsxT0dGbjNBbzRqL0J5ejBCTmxnMHZoNXFEYjRkd29sM0lTMjJHVHlWcUt2?=
 =?utf-8?B?V21FVmdYQXlua0doaU1jTWhmOFdIdG1hMWo5dHdFYUloOVc5SGs5eWdUakhU?=
 =?utf-8?Q?HxRkdLgAiksCPYb5K/TFf+aki?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90fc76be-08dc-477c-ee7b-08db36559497
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 04:15:39.8715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h9KFJ6ApqAeAaLsi+beiWVAHYOF4i04ksxt1Bp9lnaHqcYZDWjEGtKwsbEo8k4kb4+u+1QMKliI2+SfM1Zfwow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7277
Subject: [virtio-dev] Re: [PATCH v11 07/10] ccw: document ADMIN_VQ as reserved



On 4/3/2023 11:03 AM, Michael S. Tsirkin wrote:
> Adding relevant registers needs more work and it's not
> clear what the use-case will be as currently only
> the PCI transport is supported. But let's keep the
> door open on this.
> We already say it's reserved in a central place, but it
> does not hurt to remind implementers to mask it.
> 
> Note: there are more features to add to this list.
> Will be done later with a patch on top.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   content.tex | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/content.tex b/content.tex
> index f7446bf..1213d48 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -2978,6 +2978,18 @@ \subsubsection{Resetting Devices}\label{sec:Virtio Transport Options / Virtio ov
>   MAY also choose to verify reset completion by reading \field{device status} via
>   CCW_CMD_READ_STATUS and checking whether it is 0 afterwards.
>   
> +\subsection{Features reserved for future use}\label{sec:Virtio Transport Options / Virtio over channel I/O / Features reserved for future use}
> +
> +At this time, devices and drivers utilizing Virtio over channel I/O
> +do not support the following features:
> +\begin{itemize}
> +
> +\item VIRTIO_F_ADMIN_VQ
> +
> +\end{itemize}
> +
> +These features are reserved for future use.
> +
>   \chapter{Device Types}\label{sec:Device Types}
>   
>   On top of the queues, config space and feature negotiation facilities

Reviewed-by: Parav Pandit <parav@nvidia.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

