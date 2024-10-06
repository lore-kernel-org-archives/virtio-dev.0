Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2071.outbound.protection.outlook.com [40.107.96.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD586176AA1
	for <virtio-dev@lists.linux.dev>; Sun,  6 Oct 2024 11:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728214560; cv=fail; b=gC3mgpVWF/q1Sl7bEva+aunjhYiKGHE9xCkn54q0hYRcUyZ/V+FLSnecgJ/350OJBcmsg6vY2YelRVPxoY66tobHsh8p5Sv2W+iedcL5g12m2lT0GKXTIIurKBNdvz7euL8eFn2HVdG7FmqTJCEM1WZJVNuzqJY4/5BTx7rkD8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728214560; c=relaxed/simple;
	bh=CJOjZtYItPkprK4POt/qm6GNJfVVrdkolMAx0o/AB8g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AkQcsvzhbmylMBqYpWaopdB0m47tMbItQq+Ff8P6ugHp3C5eRp0H9YD4U2iooOkhdoF4wvhwXj4lBaAH7dtXWCYaHeEmgOveOJ+zxuJYHTAh13HWq/ZC34taPLSyT3XNcErygavKtDqB8SjB/P3yjVrAFyodPqFOwF/vXo2Mn8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MA+hGg65; arc=fail smtp.client-ip=40.107.96.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MA+hGg65"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hhtnv0W9qjL1QhEM8yYE+yfXLNu7dluWcz6xSeNJ1Hd8vKsXwX52vHe9feCXVg1JzOwNTKE09U8r2LA/Z5i0rQFCfdbaQkviIgYjc0DcBFlXMfnMNFqb+2SUXfYPnYQKygbZDwLaQ3G6tuID5AIWvTGB3GSIfbuZAazhryocaBYXMtKBX7OpDZZAzSn5ShLLRu4Y6GaimQB2BX/wUpWP8jSV8NYE+DR4WmfDcwcBmR+tAdXFy9nAghIjwIU1hZ6kdYqfAqKZhyR47V4ssx5B+E6nhcvx/kFWkBxkOC1nBDkzYcHa9bIwy6gcAD4uy4eBd5voOYD+y98jTWQITm7e4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtWdh20RoVM+om5lWj/TX/fDcvSd2rgb5Eht6xHao5c=;
 b=lZsfpACBYzvknmeGg5ms2nI1O2CIP7ulwbFgJBIXAaI5PihArIwKAPyP6Hm2JoOyZqXv138AbybhTjmXF8EdOC/W+zAQxFoQj2kv4qENyKFSLdwfAaXGsppo9cAR2+o2HgsyzQUatW4R6BJBVnsrVqZP9gAsWMbOBzDn6yd8nCuIike4bIHABffzSBrJX6T0D/158kLBigrLq99XHi/fJo6Ivcw8F6QsT5oKPsQSUqhbZgPsGYw0M6N5cp5qmlZh1U8DhinBVp5GRqr/PSO/0Neqe7L95znT6HZSO4IMFEeAXBrNxANSemkzm279FIvOzYN8+wMfsyEbIz00ROLcEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtWdh20RoVM+om5lWj/TX/fDcvSd2rgb5Eht6xHao5c=;
 b=MA+hGg65Tg63OYHKoIe7PHWJnVKNwrm6PiXHnu0L7SmZO+/UB/0xXvYSE/twOkVrvVN9HT62cNDimc/vwetN07TPkaC2NbxodPeziWyLKQTIjEbwXq/d4ckwMr26AVl06SM8pmbx6wQ8zzTIb7z9XSGQzD3E7NhxOYy8lKfJY3FwckxcEhtFpfUwWCRrDkoCYNVzMfnEkx9pRNRB1PHz200jJKye6jTRiYMki0EkU7aZXCchH1WlQ3erWz5hXIuDKxzCcwHkztIuw9mIihft0D03wNMoqK0TygLnuGLu32Kmce6rj8kXc0/Be/XfQ7Je4O0e3huEs5JqXvsLDJWJgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by MN0PR12MB5740.namprd12.prod.outlook.com (2603:10b6:208:373::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Sun, 6 Oct
 2024 11:35:55 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.8026.019; Sun, 6 Oct 2024
 11:35:55 +0000
Message-ID: <80c82271-b29c-4f56-b90c-e72a4ea7f3cf@nvidia.com>
Date: Sun, 6 Oct 2024 14:35:49 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] virtio-blk: Add description for blk_size field
To: Daniel Verkamp <dverkamp@chromium.org>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
 stefanha@redhat.com, virtio-dev@lists.linux.dev, oren@nvidia.com,
 parav@nvidia.com
References: <20240925145228.27953-1-mgurtovoy@nvidia.com>
 <CABVzXAntBt+5L4a1ntud_7j_EHiB4yG6FuskNaPBirOfLJ7i6w@mail.gmail.com>
 <ca954af2-4c61-41f5-8cf0-69a1233704ba@nvidia.com>
 <CABVzXAma4T+=meTSRNKhq70w4imc=A5imy2zofX2ndJz-XVByg@mail.gmail.com>
 <adf195c4-6d7e-47ff-ac62-dc4c0f463f21@nvidia.com>
 <CABVzXA=wov8OgADXbDiVVnhncc=zgET4MAGd3H1pr26XS38JBw@mail.gmail.com>
 <CABVzXAmxuVngKjNvc9AsnkuNcOK+7JeEuBE9CDaMxAA=b3f=fw@mail.gmail.com>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <CABVzXAmxuVngKjNvc9AsnkuNcOK+7JeEuBE9CDaMxAA=b3f=fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::13) To CY5PR12MB6369.namprd12.prod.outlook.com
 (2603:10b6:930:21::10)
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6369:EE_|MN0PR12MB5740:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fb8997f-e940-4395-c035-08dce5fb09fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1JGai8rTkRlb3FKU2RzNEdJYkNoVnZaenB3Nm0xQ1FLRUZsWnNacXNxdUMx?=
 =?utf-8?B?UE40NWdWd3Q0b2pvMUxNNGRpRVJLRXBsZUJ6TFZWanZXaDAvSVE1YkFFQkc0?=
 =?utf-8?B?L25lNWlrakdMZU40NlFFQklabi8vbFEzVTNlZHgwdmRTNkVJbW5Mb1pCZHJP?=
 =?utf-8?B?WTVSRThlWDRKY1pJWnltL1Z5a2NaQkZObXMydlRnUXRUdEw4ZGNNMnhZUlFv?=
 =?utf-8?B?SngrQ08zVzZBQWYzais1elFJZ2l0UXFoM0FycnBBZCtKUnowL2taMTdIMkhp?=
 =?utf-8?B?TU95dGtTemd0M29vNm5UeHlhU1hlK3ZGK1lmVjdwRmhNa0hBdlZLWGtPdjdy?=
 =?utf-8?B?djg0dyszTkVuVnRJbGVOQjI0bU9iY2VYaWlPc1Q1d3RxNEZKNDFEbnFNeEpN?=
 =?utf-8?B?SFdoN1pQN0JQbFBPdHIwT1h0ejVJL05XcHpOVWhHY1pTUDMvVytTa1gwT3NC?=
 =?utf-8?B?RVUxNk1uTGhtUlJ4U3lNRm81RWM3bkV5a0Z6cFBoMzdkMHRUK092d0dQYUVW?=
 =?utf-8?B?U2pRQXZjc1Z0empaZi9rMG5qUzF2L3VxaDJCdEFCdEx5eFVMd3FSd0NiZFFo?=
 =?utf-8?B?R3ZDUm5HNTJ4Z3JOYWgxUHA5emw5VmYweGhlbVFJTU42czdkYm9uMGxNWmxH?=
 =?utf-8?B?Z25zek9LSVZibFJQdjFrZDluVEsxS1JWb0YxbjVJbGk2VXRFdEF4eEw3MTZ3?=
 =?utf-8?B?dDNhQ3J5UlFVN3Fad3piSFp0dzBYbU4xZkd4K1lnV1NJN1dOQkZjSUVBS2RH?=
 =?utf-8?B?Um1yQVp2Vzhwdms2R0IvWDZnazZnVkhyYXY2aFFyV3R1KzQ1RGRvL095elMr?=
 =?utf-8?B?Uk5qWmQrSjNacXl6RENVbTVTTkFZdklHaUVqMEpMT2hhNHNsTk1uRHN3LzVx?=
 =?utf-8?B?LzAyMmIvTjBiUm1tWDkybkIyampDeGNHUUJvVHhBQ1BKbjBGdFN0dVJndWh5?=
 =?utf-8?B?K1k1MkcxNGpuRmhvSlJWbXFjSlcrdGplNGdhQkh2czhEYlRiY3BvNFlPYUUw?=
 =?utf-8?B?dU91MUQ3QXZhZ3lyUWFaTmRacVZ1VTZDNFZJOUIzNlJrMW5MVkRIcU9jTmZt?=
 =?utf-8?B?Z2lmWlJERTh0M0oxZHJVMDc3MGg3OXdySkI3MWVQVEtvSit4R0IzRFg3MlpO?=
 =?utf-8?B?K2ROZW5ESDZnb2ZxbGZicVEzNGhHdnoyanZXUlJRQmQ4c3l1MGUvbkduKzk2?=
 =?utf-8?B?Si9JWnIvL1N2dkZ0OEdmeFdJT29wbnhodzBNVEc3SllOUDcraExkTVZoR1dm?=
 =?utf-8?B?MHRXKzRhREliMVd0RXIwdUt3VXhTdGIxdTFDMVc0bXZVLy8vWitNK3lZSDJV?=
 =?utf-8?B?RHpoblVwV0FlODdEeVh0T2twdEd1N2U2cHEwbW9sdkpTNmE1d3d4WiticjF0?=
 =?utf-8?B?dnRNV2ZyNDE5Y2JmM3JkYnRaUUdLMnpmTTJMLzBJRVpmR2dnTjllU1FVUU00?=
 =?utf-8?B?ZUhkaUZLUGM4YnNaRVlpMnZjb1R6eklWZHI2QVlLL2JtMk0rUGpvVXpwZ1Fs?=
 =?utf-8?B?dHd2VHdqZzBhM21kc2xmdmtLUVkzMk81NlFnQ3dKUHNNVmUzdHlWc2xRL0U0?=
 =?utf-8?B?R0t5aDNkM3AzcVlTajNLSUM1cXFTbkJQWnZrNXZVdzlsdEIyb0t0MG02UCtE?=
 =?utf-8?B?Y2JpRWk2Q25VZ2lSMnBEN3hyTS91TlFTaGl0SUl2QW9USGFsOTZVOHo5Y3M5?=
 =?utf-8?B?SUlZZWlUS0V6bEc3cFIxNDBEemQvZkk5c0xJYnVQSGkwdkdkUU9xWVZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6369.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVpmbE9mM0pXekhpR0xLNC9RTnFqY2FPME1WeU10dVg5Z0QrVEZaZlorWkVk?=
 =?utf-8?B?eENRa2VPaGYzS3cvZ0dhNFR4ZjQwMXJ1MnN1THE5N0FYN2xNd3JZb1ZoOFd6?=
 =?utf-8?B?czBPcmVtQ21QaGxFQ3RqVDhySENrdEh0Nk42NFl5Rkw1UW1kK212ajAvaG9z?=
 =?utf-8?B?a1MvckJPN1o5TFBuQ1kzVnBOT0tsNktFTkczVzREcGVZeGFKekdXODBxWFZq?=
 =?utf-8?B?N1ZDWXFkZHJOS0hHeVZFN3djcjR4dUQzR3NyQVJ0anVsM0xweXlOZzl4YW9G?=
 =?utf-8?B?ZzQyTVhGUnBFdzNzNnlwK1RkWFVBSnQ1Uk83b0VxMlVhOG5VODJOUzRmTXhE?=
 =?utf-8?B?K1N5bml4bFpOdVg3UkFFbDFuYko3TG00UmRmcndjclg0R0d1S3owSE1lTEVi?=
 =?utf-8?B?T3dHVS9OVUNtbjB2dUsvSlNIbTI3MGZqemJFV0s0dDI2MHppUldwNGRlS042?=
 =?utf-8?B?aTNucEhlU1h5T1pCWGtMUjV4SmVMYVN3TmhObFBCNHZqMTZhUzM4SkRIT2Mw?=
 =?utf-8?B?cExsRHIyc3J5Zmk0dkwxYzlUYnFJbmVPc2FIV3R6eXdIY0dOSGRkNkl5UXZK?=
 =?utf-8?B?ZjUreFJNaW9uSjY0Zit2S3U0NXNKRjBaMUlFYkJLZFlYNG1vallSRkxUUTRm?=
 =?utf-8?B?Z1JUOEZTNEpLaGtnVXN4L1ZYOUhsY0lkTVh5dy82TmwvYlM5akU0ODQ0Qi9L?=
 =?utf-8?B?T09jRUI4YXNTYzVtQjVGcStzOXgxSlFMM3lWTS9COC9uOHRoZWlTUlRvSkdk?=
 =?utf-8?B?VnZuVVVlYU1XOWZGeHRSejZpZkUzSysya1ZzcExNaDZHRlltcjNHd3VBeTY3?=
 =?utf-8?B?Nkx5M3NwMWhLeUxWWG1KbTQ2Q3BCdG9yZnJDR0x4Nm00aTQwNGs0L1Y2WElt?=
 =?utf-8?B?N2dxTlBIdzkyY0hKV0I5NTJ2Ym5PYzZVbkZzOFRzRGdJeW9WamlPdGo5QkV1?=
 =?utf-8?B?R2gwOXFYQnFGaXRwS05lZDVkRVdqYVAxTWdDNzk0dzZLb0RVVmp1SkxLblls?=
 =?utf-8?B?dHUvbGIyZHNSWXNCZWJNYUVYdG1CODZwdGhjbE9rZ21VaytWMFRCRW5RN2pT?=
 =?utf-8?B?azIyS1JsMjUzdEhOMWJnY3M1RkQ0RERNWnVGbXFXKzBkNHhhT3VtT3JSREEy?=
 =?utf-8?B?OWMyYWRzaXdPSjcrTlFtaE9HbjlWWnlRa083REtYTlhGc09SZjVqUDRjYjJw?=
 =?utf-8?B?MzROWHRHN2U3djNZMkVoUlNmSjAxZDRZSlU4M052SVE0WEVROWpWd2txYUNU?=
 =?utf-8?B?eExld2ZsZVVZeFcyTldpakpTZXh1UUdLYSs2bFlEc1N1ZmFzaUVSUWtLcllU?=
 =?utf-8?B?KzVqcy9RNUNNVTBsSjhaTWEvOUtVQmszQmpCcXhYSi9CUytVSW1jTS9KMGZG?=
 =?utf-8?B?WkdrYWpzVm1rQkNicVBHdldER2M0SkJzUWxwNE5wVVcxdmVGeU81eEVLbWV2?=
 =?utf-8?B?dlZnM0V2QndDbWFvd0UvTElGRHRWTFN0YSs1aFdLK3ZYQlhzMHUvNDVVQWJz?=
 =?utf-8?B?OXN4QytCRDF5RXF4b29iSjZoSTk4OXRWTG5Ga2dXbWJIZlh3TnYzOFBkSmts?=
 =?utf-8?B?OEJWKzV3VmlDQ1hLOUpkdzZJbjZ0eE5jSGFLZ3J3blZWK2pMMFlRYnE1TG1T?=
 =?utf-8?B?S2t2a283VTQ2aHdOYnNUUXBmUTVYUHp0M1MrUFVFOUl6TVhIKzhlazc1Q01D?=
 =?utf-8?B?Z2FDKzlDY2JvcE1OU1dPZ2hXM213V0xiOEYvbU5Zdjd4cnltc1gvUDI5UDU5?=
 =?utf-8?B?b0RSa2FHRTRhWCtkNW94T1pvaG1JYU1ydUp6dXpWc3Y3aFhKK1d2QnJVU2RZ?=
 =?utf-8?B?TXZ6aVhxYU9sdDNBVXVoVGMweHk5TmF0L2lpQzhUTlNhbzd4eUxpMWhuTk5W?=
 =?utf-8?B?blAvUnVLdTloNmVzTE5QSHNZdUwrYithZE11NzU5di9HWXdYWm54a0NqSzFU?=
 =?utf-8?B?aFpqU1lFYkk5OENwMjRDQXlxdmg0R1hReXgwQjFpYjU4TUVBcEJrRld2K0xk?=
 =?utf-8?B?RlFuL1dCNXkzVXdoNkZ1RnZCeUVpUUR5WFMxbHFPL282WlZnakJ6QW56OTNT?=
 =?utf-8?B?N2s4U3YxK05ZNlgwZ1Q5MUF5YnAvTWFMTlJRU21qSnRqOExBVk0wb1J6cnUy?=
 =?utf-8?Q?Gx8rAxi3mNNbvYmNGO4TbNx+k?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb8997f-e940-4395-c035-08dce5fb09fc
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2024 11:35:54.9337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 36w61jANfd2owO0nyKY+Fs/lfI+ujf8tfjkU325e1E5veUeBh9YgktpE5tEBV1gOocj+gwb5pSmx2YRuG/O2Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5740


On 03/10/2024 2:56, Daniel Verkamp wrote:
> On Mon, Sep 30, 2024 at 6:45 PM Daniel Verkamp <dverkamp@chromium.org> wrote:
>> On Wed, Sep 25, 2024 at 4:42 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> [...]
>>> I'm curious if you've encountered any actual implementations where
>>> drivers send non-block-size-aligned requests to block devices. I never
>>> saw such implementation.
>> I don't know of any real-world implementations like this, but the
>> point of the spec is to allow interoperability without having to know
>> about every implementation.
> I did find at least one existing real-world driver implementation that
> ignores blk_size and VIRTIO_BLK_F_BLK_SIZE - the u-boot virtio-blk
> driver: https://github.com/u-boot/u-boot/blob/master/drivers/virtio/virtio_blk.c
>
> So this is not just spec language lawyering; this driver depends on
> the ability to read/write at arbitrary 512-byte sector addresses and
> data sizes, and it seems like it should be allowed to do that based on
> my reading of the spec.
>
> (Perhaps u-boot's driver does not work with the QEMU's virtio-blk
> device with certain storage configurations, per Stefan's note, but
> that is again just one device implementation.)

Vague specifications and inconsistent interpretations should be avoided.

I'm trying to make the situation better.

I'll send a V2 according to the comments.

BTW, Are you familiar with some virtio-blk device that implements the 
buffer-cache logic you've described ? or is it only a theoretical 
discussion ?


>
> -- Daniel
