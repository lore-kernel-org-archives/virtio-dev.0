Return-Path: <virtio-dev-return-12390-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F94DC77B61
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 22:17:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AA37641EE7
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 22:17:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A50BC98644E
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 22:17:50 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9800D983F7A; Mon, 24 Apr 2023 22:17:50 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 81D979863A5;
	Mon, 24 Apr 2023 22:17:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRgukE7hlWCPuJ0Iv58HmC6fqOQJFATgXaTWbPHx+lJtB94VeL7qZtTjPm9ThDXr8bN2zqznKqbkGsWBsI+Yci1uSmxMbcK104VPwgCko0eIUKgTKabsDmaAoZFxO7WWfIQ4nwpVeSGVhljGquffZG+WhR5JIv/QNyoXi4Mrqq7IkNJZ1c4jPUqDkeDrjKsjqDQy/fE5DqWZFa7W3xcfQCx0TZTknjCkBezgJ3RCzO/G11xUx/y4sQpXtquDx9LTACzsaEKoTKKxxBDpfh+DkFI3RB15Ih1QAugQ3NXc25mUQXfrnqjTNQs+yoeJ4YJeB88rl7tHffNl0HjM/A6HSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDqm8JT8j8h3tGLC5UENHVFOXOYQtx6oPJN6d/X9uQo=;
 b=oaUrrR7s+4ndXRYVgmoP/QzaYfftqU59AHJxGVi3mJWZPmND4BuCMfqw797QCJGz+jOYwAc+FxxrQEDNZcR3SZfkQAFVttTPjr3vvJsggoV2nxxwa7gSJHzFha2LdHVM5W/F89ktnFKuHvOczqH2U36fxpOFnnCPbqqbqGDI+DQTDX4kU9rgyPWyhxDu5L0PCjIoI8yUj0X0WIf+1ewkJ/x5FTdooK/2DTQB47Wzcf4f6d5Zenx+bgz2c21Qww7xxFIfFpO4eyavXXqkk/F3YkUK6GyeijMSDvioZqoieIGvtTStPc/ARKzRI3TeTfccgd66UzeHGNfWrJ1Pd3eNlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <c52c79c7-aaf5-65dc-b4e6-96791b445b63@nvidia.com>
Date: Mon, 24 Apr 2023 18:17:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
 stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
 hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
 Shahaf Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
References: <cover.1682354275.git.mst@redhat.com>
 <db86630b80459e8a40b0f41026473be5bc640763.1682354275.git.mst@redhat.com>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <db86630b80459e8a40b0f41026473be5bc640763.1682354275.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0024.prod.exchangelabs.com (2603:10b6:805:b6::37)
 To PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|BL1PR12MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: edae8812-763b-4cb5-7e1b-08db4511b954
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ip+O06lM7n61tU2UWSVqQhA51jTxDEuhHLluK/AiZ+SgILBI2DPkTynRsarp14TOY47r4jFaEQAyH1Rhhb6nWN6rYSquW6yZR5zhGExBw9mNodaKC+rbPhy0ulRqKUQrHqM0kV8xXhj+uOhcKgru5xbJGsf3LJRpUepof3zmRAPy6roGBu/323+QHGGHlHuaxEzg4kLdpMT8pCrivvgIxELgDgqSRZNKyD9J1PZM57UtXp3mqTrt5dnREJiYMH0VNq838raH5cHz0K98gmsWGZor1dCttBmVgYNzP5QJV0i5m92Lj3yglW632dH869dsl67i5VPKPByz5GkPphP3pes+4BC/6EuMF1B8QdCYP0UB2NUnCtfuMcWZFZ6JQUYxYDqM1xgDVG1tCCvsXqNYFM8P1Xms9I59QgTfhZEE23/ozan3GfyzSyuLvIfiQ6WVZr4oqwQuWcozj6N3GDguQk7mRzEMMMLz2Z7/LRB/ND7Ug1uxAyKpx6AUgUfWB6Wkn1OhSBJYX9ipcLmKzIbbJKjFv64kxfBSDutHWimAKiLH9KDVA2dMCSJiN7kPyVq2JISRcOKuBfdJV0XkjVHbR7ckZevqouZzLKl8xOE6S5TgArahrlfZlUbf1Y0YTM5F3Z7pKcusA3pL4XfeBfb2SY0fVwTSXeUUEQ3+kL8lLDUvapb+Kk0kx672GAx+Op3+3cZoigKP+XeOl2QJI0enMg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199021)(2906002)(66476007)(66556008)(66946007)(316002)(4326008)(7416002)(8676002)(5660300002)(8936002)(41300700001)(36756003)(31696002)(86362001)(921005)(186003)(6512007)(26005)(107886003)(53546011)(38100700002)(478600001)(6486002)(966005)(83380400001)(31686004)(2616005)(6506007)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1VGYWdOK01QdUNDK0NIckoyYnZTZ3NzdU1ER3RGdGl5cDJwWXNRWEFmL01o?=
 =?utf-8?B?cjNPeGhDUlFmMExNV0FuM1RqdmMvR2kyZkE1bUhLdVpDallRalNCOTBSaWht?=
 =?utf-8?B?dExzVERvVVVMQ0FnVFdaeCtuS1RwL1dsd2x4bGpZYVNDS1Mvd0JhVkRvYXBR?=
 =?utf-8?B?eWNFa2k0NjFsR2E2aHU5SzRBNENwRStLQkdLTnpiQ0FBK1ZhSGh6U0VhNUFs?=
 =?utf-8?B?SWYwOGNWSVRRUHk1bmwxd2xnRnUwdS90UE8wQXdDcE9nV0JjUDk1endWQlFs?=
 =?utf-8?B?RStGU1BGNXBDUHY5bm4zUWgzZmcvQlc3VDlUM00ybnNkMzlpdHV2SnpFNk5J?=
 =?utf-8?B?UjE0NXpXOXVSWWdOQXQ5Rm1TN3VnS3dkSXk4SlppcytoMm9CUDY1Tit1aGlO?=
 =?utf-8?B?amNMOXRzYnJhMXdkMGVsaXN6dktyd1prUmc5WENMWXpLV1FRSW9aSmpFRlJ3?=
 =?utf-8?B?VGdTVlByZ29iSThobDZTRk5YU0IzYWthNlhMbjFCRXRzOFowa00xaTZXaGJ1?=
 =?utf-8?B?dUo1eUhjSi9wSEFlL2tRcGNpNURvVlV2UDh2K0Uwb3IvSlF5Y2JmeWdQVjAv?=
 =?utf-8?B?aGVsbnFyQmpwSUZmV1dKQ0NROUVwN2hNU1Ztbys5cFJ3elpkYm15Y1AwcjdZ?=
 =?utf-8?B?NVZRV0ZSdXgxaFhtREZhTitYMWp1MGpEZHg0bzJPN2RFcTlkVmFxWjNtVDIw?=
 =?utf-8?B?bGh5UjBFNzB5a2hRTUx0WjR3elJRZzhPOFhKblNpRkV4aXRpYjFYMU9aUStS?=
 =?utf-8?B?ekpxVUFlK2F4OGtUTzRrK0JUKzBUMUVtbWVraDhuSVdRd29SLy8rUkRnblo4?=
 =?utf-8?B?MXhwYkRYaE1KZ1AwaE51UU0vc1I0Qzg2R0ZjamYrWmNvQWJhY1FEYUltSG9L?=
 =?utf-8?B?WnhpQUhOeUxPUlhURG9GUkY3Tm9xa2JOaXRkT2Y0ZjhkUWxuR1o1ZmVZNzVt?=
 =?utf-8?B?UStNczV6WWd6RkJaU1d2b0lWdlB2Z2ZBc2ljRE5iZ1kzVWJRL3JBaXdwMUtB?=
 =?utf-8?B?Y29kZUROaTM4YWtPczY5RlFRTGxnUTFiMUdCbHdQZVdqYWVkdXQvSFJ0V24r?=
 =?utf-8?B?NmlsdE5zQjhRRGhxUERCY05mNlZraTJWcHEySGFhZGU4cTdyTmNUR1hXcDdZ?=
 =?utf-8?B?MG9SQm1HNndlUmpvUjZiL0EwUHhwWGdGZ2NNOU9yNzdXUzlJNmkyL25FOGJE?=
 =?utf-8?B?OHRXclpXWlpZa3BTbUl6d0JZSjBUbTU1MkQ2Q2VLS0gzMzV6Qmc5Tm5HVjRa?=
 =?utf-8?B?MlNhZWZWWVRCS2NQSHhsd3dXM0JpZytTRGpnZ3ZCMnJNa1Jqc2hDeWxIWGY5?=
 =?utf-8?B?Q21DRmpxaHZScjRSczVRNzVIWGpTUjNMZFZEdU1uUnpoRUw0S05ZQ29hVlgr?=
 =?utf-8?B?RjVlTzZXcEQ0Y3RwZXJucWlQTG04REdlLzJvWWxMQXFMOGppdzkzaSs4eTJU?=
 =?utf-8?B?S05uM1JJd3NESm9ZN2ZSRWVETW5qS1dGRVR6QlYvNEVWd2c2V1NER0NSVzNG?=
 =?utf-8?B?cmd4Vk0rNmErSjREOHVNdWZWVHREeFZmanpCbHJ4VG5CdkNGbjFQdEUzc04z?=
 =?utf-8?B?SkRCejljVzFaeWNCZDJBSDlLdG53V203UDAvVEdZaDJJSTdGcDJtdFRFS2lT?=
 =?utf-8?B?WThkdHpwTkgxSTNZOFJNTDhkNGt0Nk1ycVIyNVVzOEZ3UEV1aXlCTkV0OTdU?=
 =?utf-8?B?cEVKd3ljQUJ2UlJGSzFTOWJVVWJFT2tjdUhZcXVqL2RQVjFaWTZwQjhCTlZZ?=
 =?utf-8?B?Q3NHVS8yZURxeVRlMmlHOW1wSytYSHFQRzhJVHozcWJtZHRObWZGcE5pNkFD?=
 =?utf-8?B?KzhGYkRMQjdobVFTQ2pxMmF4aDl1MWRLbWQ2S0tFRTNWNmhBQ2pyMzRyeTM1?=
 =?utf-8?B?NnppTXROTktzZTYrSUVUVkNrSHc2YnNycGFsZW0wUC96ZDIwVS9GUlNXVzM4?=
 =?utf-8?B?RGRrbldqQUMxbHNEZzJnQlRjWlExZzNBZ0JrTitxOUg0L3hEOVJRK2hOOHRS?=
 =?utf-8?B?Z2g5bUxIeXlYYU5VVmtGRUNDMGVTMUttUUZOTzAvdmJlaHdFTS8vajBJeTNj?=
 =?utf-8?B?TkdWTjFiSkF1d25JN0d6SFlOd1p0ZzNGSGlHaWtUVjJtemF3eS9qMTdzZ1hG?=
 =?utf-8?Q?rR9BjMZtX/HNaGfmCJMKco5x5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edae8812-763b-4cb5-7e1b-08db4511b954
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 22:17:43.0711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UcC1vRd/jDav4zxFa1W69N8xDmHuza0dUu5YLRUlNZkhc2OrQn/dmufu7mp9rGnYeyVDfhL5c6KD7tHNHNlrZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5945
Subject: [virtio-dev] Re: [PATCH v12 10/10] ccw: document more reserved features



On 4/24/2023 12:44 PM, Michael S. Tsirkin wrote:
> vq reset and shared memory are unsupported, too.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/160
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Zhu Lingshan <lingshan.zhu@intel.com>
> 
> ---
> 
> changes in v12:
> address comment by parav
> ---
>   content.tex | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/content.tex b/content.tex
> index 1bc9af0..fe032ac 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -2988,11 +2988,13 @@ \subsubsection{Resetting Devices}\label{sec:Virtio Transport Options / Virtio ov
>   
>   \subsection{Features reserved for future use}\label{sec:Virtio Transport Options / Virtio over channel I/O / Features reserved for future use}
>   
> -At this time, devices and drivers utilizing Virtio over channel I/O
> +Devices and drivers utilizing Virtio over channel I/O
>   do not support the following features:
>   \begin{itemize}
>   
>   \item VIRTIO_F_ADMIN_VQ
> +\item VIRTIO_F_RING_RESET
> +\item Shared memory regions including VIRTIO_PMEM_F_SHMEM_REGION

Please add VIRTIO_F_NOTIF_CONFIG_DATA to this list if you respin v13.
Else I will take care to add it subsequent to this series.

Reviewed-by: Parav Pandit <parav@nvidia.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

