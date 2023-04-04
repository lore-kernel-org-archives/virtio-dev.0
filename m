Return-Path: <virtio-dev-return-11976-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88C7C761A6
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 16:09:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 249EA42B6C
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 16:09:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1043C9865B3
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 16:09:04 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 03411986524; Tue,  4 Apr 2023 16:09:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E50E3986583;
	Tue,  4 Apr 2023 16:08:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zw7KpqU8mUY+JN3npfyChkbjCtGUAxWDzx5dCQ7XPLyfxNLwW958kAx0zN6Sfa0olXKLEqI0JvOgUrlH50x4w39mx81DPAey3Jymv5lJCKcZxeajkgRdzNrtSkMKczbMxvK76RNXokNUpuMFanjZQyJ62LsXboMlssnZlRSDlWpZ+GbqPFg1ca69Ri/2Sw8aQLJ3bpj6N2wpsvWxgslwoMLE0mHIVrpqMl7kyLguSK2N5aI+iCsHVqvS4Sj1OoN7LF4rz6S+d+FCiFBMpuTJFPzJAdzZwYrnTECdikbUloXUK3tYWOT0lfxmYOUSsElWZCCxmYyvTdrUX2CgOs08vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1sTGxbn6al5/OCUEuxZStFKAkFNf94D4ztmJNXAORn4=;
 b=O3dWMFjW02df4w1msVos3LQvsRqbgyNdVQopjYcw+N+oC27MOZf8HjMVTSZyb27YaSVHTD5ENMzD2HY1xeEmWvVhQJbe2JDNyCU6WHOgwyPYx63Gcjye4T5dy1qV90fJdWKD7C0IGDWtIeCpVNZkgjyJrpMUHIJwIkaJLaulMp7CpswZck2ItfHN3pHwU7wF61x6JYnodY5PgAu610q+ElzDXB9vjfQRxy0IyGTRw8R2Mmctb28ySz2JcWpB78XCDbb6JP5mci+L+J6VD0Jb34HCaG+O7y2nskyB+Y4hmgNH2vKweEjeEZ13+dnGse9krWU/9OyiF/6FSu9h0us8JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <94b217ee-29d9-42da-f2b8-28ced7e64371@nvidia.com>
Date: Tue, 4 Apr 2023 12:08:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
 virtio-comment@lists.oasis-open.org, shahafs@nvidia.com,
 Satananda Burla <sburla@marvell.com>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-8-parav@nvidia.com>
 <20230404032700-mutt-send-email-mst@kernel.org>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230404032700-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0024.namprd11.prod.outlook.com
 (2603:10b6:806:6e::29) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|DM4PR12MB5165:EE_
X-MS-Office365-Filtering-Correlation-Id: d9e58a9d-8072-4de5-7a50-08db3526e4a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BrwtnRG81xxtQ05p+fVR6LcpVtNMSjm6GgshjBkovfzL8m1ibtAlfrrj9eLtLCkVTVRtQLJOeCjlfCxA/ntrc9PYZuzq/vu5An4a8nqZbEy2Z7MHwSMp6FI9e1Pi1yTJZw8OC6HOiolMOtBzh53HGASSTCddIxgFzGnF+ffz83pkQKeKEICWkO3LETGr/fAemPX4LjRzAy73gpqCWRj9Fh6fzBHGKwwbGydwpdiKXtGRs5ZRG7e9kxnr5j6kVN8EfT7uadk7GBzuBFuGm8Z9pt2VKFfvhI5zhZG+FColW2FUZ5XeYcA/zjNiklxO8McJ52zPuDZq0Q+kkqDWCRJ3a8MVoXmGy3+bWZLE3oniV6xfcqECpI+QChtIWLCKuB9wb34crylwXAQfcpozd7YyviZiKKJMbvv3KZVUaXcjrPpYAH3k2Vm0ZJ2hO4QQ0KcqPm5DiogAr7ygNxoRIypI8qnumPuYVRb8dqDWi3gzkFAMc/aO0+NxZFgMyosQcUgIvVJSS0dL0Y1ZWeB+zfG31vsf1cnQTvJn18zTAdigznHgIvO9qh24CmtWAL6iS3tQWK25FvgsD8mHUm2r+H3nJFQHcaRWLnrejwgC9E0PxxNrT1Lflwuy8wSZugUFq6rK2DSRl3Iy6WybTcJBLArw1Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199021)(31696002)(36756003)(38100700002)(86362001)(2906002)(6506007)(6512007)(26005)(53546011)(66946007)(41300700001)(66476007)(6916009)(8676002)(4326008)(66556008)(478600001)(5660300002)(31686004)(8936002)(4744005)(316002)(6486002)(2616005)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1draE1GZ2s5Zi9UdklHdDVobml1Y2JmZmY5a3YvTE01UG56Y1RMOTl6ZEFQ?=
 =?utf-8?B?a2FDK2hVZ2dCUHkzeFp6RENIRi9DbGhGcVJKZmRsVVk2ZDVKVTAvSGhKdk92?=
 =?utf-8?B?TUNYTWhERjRMUGhiYzhFMDEwbmRrZFJwVTJvM2JoOVpYQ1ZnZndCZ2pHRG13?=
 =?utf-8?B?bCthN3J0bFhUZTh0SE8xRzVWZUJYR0syQThWbXB0UUg1MmZpb2pkTGh3cGVa?=
 =?utf-8?B?Tm92SkVDWjF6SXV0TzlwaVpzME5qSEVQbmJYMVR0cFRxNjhOejdFNUJWbVE5?=
 =?utf-8?B?enNOeXo1MUlyK2VyemM1bEFwWDc5eEhSaGdjc3RMNDdwNzBDVjZVWCtOc09H?=
 =?utf-8?B?UEtPZWVNcFhPSEtLQkVRaSs5QzV0SHlCVnN0WkhUNnNFNmlMd25pazU3Tzl3?=
 =?utf-8?B?bjJ0aTMyalNqTHdGc0x5RGVFNkZjZXpLdlJTcGk4RHN6UENTUmU1SUNuMTBK?=
 =?utf-8?B?dHR4L09ab0tGUkZpYzUwS01XdW1qMnVTeVNFdXJPZEtiLzRWZ0ZmYWFrSVc2?=
 =?utf-8?B?VU9aZ0gxTUtXWkYzcklSNEN5SnlHTXdXdkZVc2xlSXFGR1lRaXcxZkl6UWxO?=
 =?utf-8?B?MXJsanZsQ21JRnpaQUYzbzdrcWd3eVg4V1FDQ0M4MnJ2bE9Tak1OTVFzUmY3?=
 =?utf-8?B?SVVhK0FIbW5yR0p3cHl3QTR0QjAzSVZPWlp3dnNsZFd5amRibTErbWkvUUMr?=
 =?utf-8?B?ZlNFaU1QVFovQytIRzQyeWU4aVB3WWd1UGFYM3pOZVkycWRZY0ZHVi9EN1d4?=
 =?utf-8?B?aVd5a3VERFpIRGFhZUtERDhZRUNDZyt4VUpLakc5WWdORUU3TmZINE9MZ2c4?=
 =?utf-8?B?aDhrMGZzZU4xWWl2MHcxS000TkZYMUh4ODZFdTR5cDJpZis3NHAzTExLdm9p?=
 =?utf-8?B?aUlGOFNBZUFMSGk2QVByYi9hT3pKLzhTQ2s2d0VqUHpkSVZ0YVd1RWk2Z0xs?=
 =?utf-8?B?YlA0NklxcU5BREJudmFRamMyUjhBbDg2c0praXBtZG5ZM0NaMm9TNU5XWUpq?=
 =?utf-8?B?NTFhKytVdEhwVmlwdCs1K1h2YTc4eVl3WWdQZkpLSjNRdVdrMUtRMzNPK2hl?=
 =?utf-8?B?ZU9HQ3Q2NTgrdzJLVlFJUzZnOVQyVkplTDJRc004WlNEd09XQ2dEZW05Y0Fo?=
 =?utf-8?B?N0UrVFJtYnJQbGRINGNLUHVxdUQ3eU0rYWE2QWRNZWNkWTh3TkpVa1hicE1a?=
 =?utf-8?B?MU8wUERSSTcxR1QzWkVTSzdjYm1FZmhoT3c4VmtkZGgrd2RHeVlxYTBrVXE2?=
 =?utf-8?B?K2RXeWhodXU4OWNVNWFwSU13Ui8vNitBT1gwcjVXOGkycTJGeUhCd2VhMkNX?=
 =?utf-8?B?N2ExalE1cTZUd1lXdFdvQlpCdFZnY1dlaVdSeGhDQjBta2V6WG5ZdmRaN3ZX?=
 =?utf-8?B?S0NGc2UwYU9waDZOWGhnRUVUZEtTaGVuN2k2cjEvYXV3V0NrNXRvajkwMlhR?=
 =?utf-8?B?c3o1aUJ3TDNTdXAxL204RWFMWW9RdlQwZHYzUHkwVmoyekN4cHFiaEdRWE95?=
 =?utf-8?B?MHd4N2VzUXI4RGpscFFuZlJEYTFMTnNnYUw4MXdWbisyWEkrQUVxekJ6MHhm?=
 =?utf-8?B?aXZTTStJQVIrT09BMENlWlBwRkVIRnB1bDNFbWRFb0JXK2ozN0pQR0hldjIz?=
 =?utf-8?B?OHdya1JpMkZDVnJUbzdiQ3NYaG4xekZKYkRVcE5wd0Y2VTBsWjloTFMvVVJ0?=
 =?utf-8?B?MlN3TG1ZRFBqMEliT0sreU9wMkV4ZmczbFI5MDRCeVRtWU1lb3drNTJNUDNT?=
 =?utf-8?B?bWt5OGcwN2xybjdBMytsbTcvK1dOS0NPRDBLdGp4bHNPaWthMXE4aXhlSVJT?=
 =?utf-8?B?Zlhzc0x6WVhTMFBFTmtnZDJhbWJIMUd1cDVYK0ZMQ3lUN3hJZjFyVG1lMmdy?=
 =?utf-8?B?YlhMb2l5NlROd1VpWlh5azM5NHdKZW1JVXZGMHMyMDRTTW5RQ3B6SFBiNzI1?=
 =?utf-8?B?Z1lsd0Q1SXZxaUZyYTUwbU5jMUxiV1E0TUZxWXAvaG1qN1o0M0QwcVYwRzRU?=
 =?utf-8?B?KzNzUXZtNjh5eWF4R2RSNXFHeE5iZFJUWWxNczNmTzBwVFJGdWhzS09RVGdn?=
 =?utf-8?B?YW4xMUxTcGd2S21xYmdYQjJaQjYxOXR6cDlPZTkxdy9NQzlMS3llYzQ0RGtl?=
 =?utf-8?Q?XBv53ST9/Qb896mLw4h/diXzD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e58a9d-8072-4de5-7a50-08db3526e4a8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 16:08:56.6227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lHmK8pvLM630lODbpIDlxaWb+I595x0ACd8+S5EubHTWvYzitl3Aom+UetAjBdJpt7hYYjtEpn/WQXZRBnagLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5165
Subject: [virtio-dev] Re: [PATCH 07/11] transport-pci: Introduce transitional MMR device id



On 4/4/2023 3:28 AM, Michael S. Tsirkin wrote:
> On Fri, Mar 31, 2023 at 01:58:30AM +0300, Parav Pandit wrote:
>> Transitional MMR device PCI Device IDs are unique. Hence,
>> any of the existing drivers do not bind to it.
>> This further maintains the backward compatibility with
>> existing drivers.
>>
>> Co-developed-by: Satananda Burla <sburla@marvell.com>
>> Signed-off-by: Parav Pandit <parav@nvidia.com>
> 
> I took a fresh look at it, and I don't get it: what exactly is wrong
> with just using modern ID? Why do we need new ones?

A modern (non transitional device) do not support legacy functionality 
such as virtio net hdr, device reset sequence.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

