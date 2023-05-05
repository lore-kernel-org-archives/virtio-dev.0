Return-Path: <virtio-dev-return-12599-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46883C77B7F
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 17:23:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8A59D4434E
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 17:23:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 816DF9866F5
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 17:23:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 74EA79866C6; Fri,  5 May 2023 17:23:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 617D69866C5;
	Fri,  5 May 2023 17:23:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtbQ0Ql2ElypLLbCr3FPtFJUFwEP9/6tzKpE7Wl0BONnXG6sfFL2rUqdqZgRQzUq3amn5ioBQEb3DT4Z5735s2KTJqPbJReLvHJHZ+iJdXu1M4lXcgk8XYxtHHS6mJF24bqR9RDzxM95xR1gkSmpavLy2sAnsk+ul9jD/Z8ZGqs1N2deed5YZRggG69fmqVAbv0lQfuHW1OSQq2H9/nOyjgEn3o+7ogg+oD9J1GstEq8cJen6EYJYqKxlllDDtNE+fAPzxGdHI/a2Tx0EGtorc04j6s/KH2goBxI+8CqOi//ZuKUMsf2ltSPbP39CjCO/hRffWH2EphDQwhogDa9aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJsZ9HZA/1PHniZf9Ru/ST+V9uqKewnH1Tx9FIkaFKk=;
 b=hWaHWarEq6qCkfLNED6v5atenYFjiKrriONsNdslDK2NrkJEoHLpTmKyOcSKBUJf3jjFmtwxB1VEVhS+BaylfQGQ1juaIj4iw0axThQoBNTS49rHVVEk+h7tCQgfpbT9vWkYwV9ZXFqRqo8oVCMx+m5FF24mJNzmte7UzlPqhIMoaVCNph7wIoIIhPqLQ4HX5pc2h6E9E+AaXIiKZ/I3tfPs+BB2Fi4dcCKWN2mfW0I0jD6d35Ba5D1F8c7XB3SI3Ig4JCkxajZX+iI3DxU0IE7xD/nV667adbCAbTBUzWSBwHvua1hU/WFa7RaV+WBC9JE7Qve1Bs6bHCO3+/iZtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <1ef8f3f6-c52a-8354-4898-bf29e37cc983@nvidia.com>
Date: Fri, 5 May 2023 13:23:02 -0400
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
References: <cover.1683301091.git.mst@redhat.com>
 <f4a163a843456c339dad4287c518a1e24cc47f82.1683301091.git.mst@redhat.com>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <f4a163a843456c339dad4287c518a1e24cc47f82.1683301091.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0132.namprd13.prod.outlook.com
 (2603:10b6:806:27::17) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|MN2PR12MB4143:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bd69759-b67e-4fbf-2388-08db4d8d63d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PY26e/vY8HXGJXhbJmbgBrqywlT3VMUXI4lZGezDFhkuiaAwhwzK6k+l6b8tSmemrBlkGZyjdG1U8lmxE82rsnyso3jnQlHOwOr0GOZx2KnyW8FOBnKIc29gDT++IjMqEnCP0q/14VCBu8Vboa2VZm+nt+GYk/TFX1cKTcgp6WIdyNWRwpQMEwBEayYw6s6yh1oSOewqac3SnGFvqpC07xjLJFInUFKsmvioZEXI6aM6d+KfoCK07VyDTn6m9BlHGnCo6IIsEut54FnTllozt4IOmOA3InUDKT8c7etH5Z3Amb6vsPf808W4YU9F/Vno5c7NQIKNZwvI2zsnwft+Bn03FpSarqb6GOgFssIxHhXA1nTgzTPxOTczRrQwZwEz1m+AxaDKc0+4Ilarr0SkVS8FHS3zWKGr9c7hvqfD2lGCKmB+G9BEMIySwi4w7bRKQRv+CJpjNCWn5hY231mZKLJt78qfl7QxK0oTd0/9xINq9VY+iOGEdiRZTmiN84hhk51XqqYR+m51pFVLawLtdfb2wNQVhP7JYV+j0MD0NPluDZ7I5cMN5O6IJh0E1Qk1AUaOuHTUAa/ENmMARpgPC9Qi17soFsxDCSuQmHQxDD0emIzQV4UzIGZmAkBpnaZTzkYuHpkywnyfL7IpbrKopJ0cxRRjh80Vls9gYgyxp1ayZVgkc/Ndon3zG8kk1lKWZvk+G8iDK/o9nhzDVoGmmQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199021)(31686004)(966005)(478600001)(66556008)(4326008)(66476007)(6666004)(6486002)(66946007)(316002)(54906003)(36756003)(86362001)(31696002)(53546011)(26005)(107886003)(2616005)(6512007)(6506007)(4744005)(5660300002)(8936002)(8676002)(2906002)(7416002)(41300700001)(186003)(921005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHRrQ01JWVU2a0FVeW5BMU1VZi9FVzlweXVRTDg4TDhMUkg3dGtUMThKQ3hV?=
 =?utf-8?B?eElCNWNISXp0VkNubzBNL3o4Y1J3bTdoNVN3Wm9YaXBhVU1kM3BmZnBPTEQ0?=
 =?utf-8?B?RWhocFg2NE9TQWFRZjVpcGJnQzU3aVJILzh2OXJCbW5LOXFMK1ZhNGRIeG54?=
 =?utf-8?B?eks1Ui9Qd3c0aUhnd2FGMEpGazJGSHhKb0dndUI2M0lxKzVwT2ptckRiSFIv?=
 =?utf-8?B?d090SDhGTU5XUU83YVZOdzdTN2hjdnlGV2k4OE9wRHZNV2wzK1ZmdWo0L2Ev?=
 =?utf-8?B?bkxtZVBJZVh1aEk2S3ZmdmxUbnhBWGdraldSUnB5OURkNUtGNnJnWFNYQ0l3?=
 =?utf-8?B?QzJoK3NvdVhSU1lHWlpPNVBKMEZWam1EZThPY3dCR0JicUhQbWlKTytpejZ4?=
 =?utf-8?B?a1VFUnhqbm53TWlHNlVCRlBmRkFsSzVMaDFTd01FRTFwcXRnNEU2S2NJMEdr?=
 =?utf-8?B?VHZDb1RyVVI2ZDAvdUNmeG0zalRLMzM3czFPcC9NMzFzMlN3cndFQjRGU29y?=
 =?utf-8?B?eEJkQVRDMmVZaktjRDR6R0oxVHNLTWVaS0dhd1Nua1UwMkJHNkk3NUZqTFZC?=
 =?utf-8?B?dnNpaWxjYkZyZzViSFBHZlo5QW40ZzFadk5JTlRvblFUbDkzbDZFdkc0cUto?=
 =?utf-8?B?cHo1bUg1d05Ga05uOUZid01OVE5SL0wxWDIvYnBnMFk1dllucnZBUXJsaWpC?=
 =?utf-8?B?cUZpV3pkMzlsUGJRcy9GVTJ5OFlkNjRMWjM0SU5uQm1JZlQyRGRRZDFsbFky?=
 =?utf-8?B?a1I2aWgvQ1E0cGJPYm5oQUdaRFpSVEpYODYyMlRkSStrbEx5aVBnSlU5WW5s?=
 =?utf-8?B?U3JxcWlmUjlRSEhyL205b3VHcTZrNzkxNHlLdmwzQnBJV1hTQUlJQW5kUGpE?=
 =?utf-8?B?ZW8rbWd2b1ZxV0luQXJnYlJyRUxleE9pREIyUkROZXk4VDZmb2sxQ1haT0tR?=
 =?utf-8?B?WlZvK0U2Y3VpZUFWWjQ3NlpNOGRDeXpaOGZwNEFjSWllSEhwcjFkcFdvbnJ3?=
 =?utf-8?B?Z3pmaGRPWDVVWnRrc1RGN3Y2OGVPd0Y4ZHFSanJjU3hhSlBMVkVkcHNweEN3?=
 =?utf-8?B?ZkM5UzJQcHduNFBCcHpob2FFbDJSa3l0OC91TVRHN0pyMWVSeDVZN0VlSSt0?=
 =?utf-8?B?YTE0K2NReGMzaWY2cklVdW55cUM2ZEg0MXdrazlJajdIUElRYVNGSGkyVlNa?=
 =?utf-8?B?YTVDOUJVN1pjVU5xZDZjbk50bXNpaUx6b3FWUThPRlZmcGsyNmFUWWU0NXdv?=
 =?utf-8?B?MUxvaW0waEJhS3FnZU9uUDZhMUNMVGNoQmsvNzltSHpSME9DNFRQRFBEMUI1?=
 =?utf-8?B?RGRkWllTUWUrRGt4Y3BwLytiNnJUK0hkZEUxbjNJQWlmeksrbitIMUlpeXZ2?=
 =?utf-8?B?dUNvMDh4aC9sYWZ1NU5sazNQZXAva0JrdXBsTnFQTkNNSUNLM3kwSnZZS2hv?=
 =?utf-8?B?TUhNSlJyUWxCc3JOV2tCakpURmJmd09EaUhQM3Bna3ZReHpFa3J4Vm9HSThV?=
 =?utf-8?B?Vno1SHdyMWUxSTA5TjRQT0dhN1B2NHB3VERZUE02R2ZSb1hXT2pDcGJPdWg1?=
 =?utf-8?B?WS9aVW8vMXp1MTVxdTlja0JoY0R4ZS9HbGduV1BpR1R1cUt4Mlg1SDFFUTFa?=
 =?utf-8?B?aGFyZlRla3ZHdTRRYkZLQUk2d3ZTVjJsZmlyYVFoRWZzQTUxUnVNdFd4Ty90?=
 =?utf-8?B?d0ljeFdZZGtKSlhiU1BRak5sOHVaa1I2b0pxakhGNkdCd05DVDBtTnB3ODBJ?=
 =?utf-8?B?ZjZzaytyV2RNQzdVVnlnbGFQZTRSVjlDRnJ0cUFpdXo2Vnl2SjlBb2I4emgx?=
 =?utf-8?B?TnNTYXBQaEc3bUEwTDlYUUNXd3JjamZsUThibUJ5RHRydVBQVlUwUlVxdVFv?=
 =?utf-8?B?c3VnWDZ6LzVkLzFUWkN1cUlxKzF2ZUcxNkhzeGd5SXg1SFEyTWttd01CeDdr?=
 =?utf-8?B?cjNIVTlBcWhhYkF2cHNqQ2xxUlV5QW5IMi95NUxsQjZBN3RLYjRkdmZIQnZ2?=
 =?utf-8?B?aGsyQXNTTlErN1BLd0k4TElxWUhBZ2NlcDcxQk4wckFicWN2eWJIUXZCZVpo?=
 =?utf-8?B?Ui9hUDdXVEtyV3QxeGxyWkZXaWxNQVJyOHdUa2lUYlZ3T2lOODRBTmlUd3V5?=
 =?utf-8?Q?G6DjZEJWLeBeJwATDOWgXxutv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd69759-b67e-4fbf-2388-08db4d8d63d1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:23:06.4819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 04YB/5NYUJWIaOEHHnsNX65v1n6zrXog8chIOb3kLqTlg+PCgHm0Bc9YhNL0gY5lYzAG44z1OthdRQFdh3EfBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4143
Subject: [virtio-dev] Re: [PATCH v13 10/10] ccw: document more reserved features



On 5/5/2023 11:41 AM, Michael S. Tsirkin wrote:
> vq reset and shared memory are unsupported, too.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/160
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Zhu Lingshan <lingshan.zhu@intel.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

