Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5351B1C9EA4
	for <virtio-dev@lists.linux.dev>; Thu, 10 Oct 2024 14:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728569110; cv=fail; b=F2caupPODfWJWjsmEYomK/GMIY5gUxI5b1gAe1MY1Cx5g55C7x4ySO4PbmHnn/VKRrbCJzPtkVlMX7LC1m1YvDF/euwv5Q01SRiTKqjhTFQz1Xck7XzshGsyrNgzrk6Rx8P5nAviwXhbbVrU8/bkI6uwPaCi7/IO9WsGjWTrR/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728569110; c=relaxed/simple;
	bh=NNIhhKbu0/iRs7y55sLhKvtKZNVTL4CW2DJVUyQuarc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iEvQBjjoKoEpjK0C3vlpiCA1rM6eqx+XVwWlRlBLWa9S3nmwbaHEJhLYnW4/z763yu8dnFinoraQPe+lm/08cXlW9i+gg7xkZ6Q5rCULR8n08VAFtS0fd1FqaQ1oxhKwEhTkBEoGSstV5qL2pZLZ5IjO/4/nP+Ri5otVAnlF/U0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ay48CBr8; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ay48CBr8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Okk3GnFNQXkxIAVCaRFXKLvFY2kGtUexhsgQH87Bn5twSM30VzaWHgjLXMqmAgecvTkjxG3IwK0EtpZg+RnBPrNKiX9I4zV1IGdO/xm/55A2NeRvwHA+pRdDsQ6h+G83VDf7efSHZ0RjlZ5L+P4vVZP+lEHlEyr7u+AJEmtikb16F+kEzzzJvLqG4Uuk9hznx2zMo+lWVazk50SSNttjTfxyIRjnIuuQMyI/3BXdvwsfp3rsFFwqFZP4Lep1oFLog9rVvTIW6OthTeEycyDnFhZM2MovEwvf+5NpJOnk4HCZC65T1AN4YLRKMmjyy+olmZVSbSri0zMJ9NCyJs+Dug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N20gY7+PnVnjyfKz/HFF6WJMr8bLpIXIQ8/OnWnK9QE=;
 b=Z65DEoQZqB/fZ5E2iebntlt265sWcm8iwJq3JigfcCA2iowT4lX2wzAZfUIfqaMYgh7r4ACPKpRpy/8xITl1bfwVjldFspq1ZU7NAWiqS5/2zrYFkQyx80Kr2lxgsCV4FCpkpggv7SHry3Yfin1I28+t9sM1/u+hTA0OYuRyixufbWSg4gr6a5Aq42UL2ipFAKJv+IGRKoK6XX0/viR5jkpZ1L2pGz3n9L2eGOjkHjTV8kwgIBlR/1zIM76Aj/K54t2Wu2sAhDeEmodgUBcDExullrOCrhlq7BMvxu8ZDTYQ2dYvxs2zt83Xka2XpioxCsXrvj7hNNaBFsF70gtGrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N20gY7+PnVnjyfKz/HFF6WJMr8bLpIXIQ8/OnWnK9QE=;
 b=Ay48CBr8xwhDedBMTSr/LrvYPJlTRI9iDYWUQ9AB5+rbLAb+1sbIj15dkLdIOyZKmXVMVazT5IVzUo/5u9Pvl770ysxG81m9ddY7Pj6T4g1qMcDfd1d5n+YvCVhv+kp7t7Xh1fudYNsJG7aJbaQyQVWcjS+iO5n8n5WCh6gJHwSzJW4IcRdyFIstlusAEbgbRsnu61f3YC9aarldFQA0MUo6E7wZO/vT0s1x1oXQoRJ7B0yE78QpdQmZKNLmXN5EL7daJjUO2JakF1r8ZRbTM+98UtgOzLWWMF2hJVm89tIDYvg/cztHXnKqaGzl0J5OmESBv4hAc5xOXorlG7vtFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by SN7PR12MB8601.namprd12.prod.outlook.com (2603:10b6:806:26e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Thu, 10 Oct
 2024 14:05:03 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 14:05:03 +0000
Message-ID: <e893a183-0eb4-4888-a8b3-25c1ca12464f@nvidia.com>
Date: Thu, 10 Oct 2024 17:04:55 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] virtio-blk: Add description for blk_size field
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: dverkamp@chromium.org, mst@redhat.com,
 virtualization@lists.linux-foundation.org, stefanha@redhat.com,
 virtio-dev@lists.linux.dev, oren@nvidia.com, parav@nvidia.com,
 nitzanc@nvidia.com, benwalker@nvidia.com
References: <20241009160512.8390-1-mgurtovoy@nvidia.com>
 <ZwerV4qPST9bbJ1O@fedora>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <ZwerV4qPST9bbJ1O@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0354.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::11) To CY5PR12MB6369.namprd12.prod.outlook.com
 (2603:10b6:930:21::10)
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6369:EE_|SN7PR12MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: f0b15b35-7c18-4009-5f9c-08dce934893b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUlDTmNYTWV6TXpYK2gybEN4dkhHR29LVTVvWDFteGkrdjBuVGxscTlESmZR?=
 =?utf-8?B?TzVCS2ZmYWMyc3BBRGs2UUlYMWMxUVVOL2ZBcWdBalpGc1hZOWF2U3hOWmxO?=
 =?utf-8?B?N2ROSFlEQVp4V2JTTjZ5L0djVDRMa3h0Y0QzUEROWVdYMy9SWG9PWkcvNi8y?=
 =?utf-8?B?eTRmTnlXY3RtbnpqdmtQdTNRL0l6OWFkclNoa0xreTFvek1ETGpMVWt2ZS9r?=
 =?utf-8?B?NHhRcVAzUDdqd1J6K2NUS1pCbzJSNDhYR0JBcmlRTmp1OFRoeTQ5elZhYmZQ?=
 =?utf-8?B?MmNXUFN2eEVBbDR5a1lPZW00Nm1nOG1FLzVlWnV0bFN4YTgwMVo5UzJpOW1s?=
 =?utf-8?B?RXhWZDNqWUMzN0lUK0Nncm9ub0tjSjBuYkx3U3k3cHZoYWtkU2tESFllSlZN?=
 =?utf-8?B?YkVNMFpqRExzdXBqYnVqWlNRVlNMTkdqcFhhdmNpb0U0eGZmYmEzeU5IY05L?=
 =?utf-8?B?U0FSTVF1c1o3dUJQRFFCZkFmS2I3eS9Cdm1vYjlhQVJqUi9ycjRSdUJEZ3JI?=
 =?utf-8?B?SS85ZDBVNzMrSnJSYXEzdmlTcDY0NW1TTDVmQy9jRnhTdnpBUkNwZTNiQ05J?=
 =?utf-8?B?R3hUeGt1SzRxQi9JRWNocjk5eVFZNVdpMWp3UkNqRFI4eEVSNlc1QXlzNldK?=
 =?utf-8?B?VzVZWnVIcWprVjdHeGl4ZE9USytydEVmd015Z09EcFpnNlBoUStoZ09sbnBQ?=
 =?utf-8?B?aG1wN0xaWUlKa3I4ZTJEVE05RVBDanNjb1VZYXBZQzFsRlVXc1c5WnVUZVR2?=
 =?utf-8?B?R3owbFFLOFZPZVRNVm90a0ZzNWwycEpqa1BWZXNRRVllMmhINHk0RVQ2Uitr?=
 =?utf-8?B?b09iemNJWU1BVjZBZzRMK0xURUZuUUdncis1a3JPWnlKcTJORkppQjNVSXEz?=
 =?utf-8?B?SHovd1YxbmVxUnNJK3FXQWZGcjBpQ05hbUxlcVA5VUVrc2xEd3NTUS9UK1RE?=
 =?utf-8?B?ZzhrUEFZQTJZelRnN05MOCtLdVdZTnFvRTBVNC9LZ3N0bzdqWjJ0dWpkNXRT?=
 =?utf-8?B?YmwveUFXeGprWTJ0cjdTRGE4a0xrV2pDdVk5cUtEL0srcjRLY0JHbTZHY20w?=
 =?utf-8?B?L1pTTlliWGdJNmFYZXk1YzNUSDhwNnlYdXhoajJRdmJjY1pKeEtIZlN4N2Ir?=
 =?utf-8?B?bzRtbmRwQ0JXVlpWQ1paSDRvRDFONnpMcDExZXpHRWhVUjJlcHJDR08yUEtH?=
 =?utf-8?B?ZEIrZVZyV2ZzYkl4WXVMTlU0RnRRcUMwaU5jMndhRjRJN3p6TUpXVFV5OEF3?=
 =?utf-8?B?SzdRZUNuMkppTEJFdHc0bDZRb29TRzdJVFhUSUthazgzd1h2Q3k0dGhPRUVG?=
 =?utf-8?B?ODhkQU51aUNSWFIyelpmeThoTTVSZThYai96QjNZWTNHZGdlQVVKUUs4eTN2?=
 =?utf-8?B?WmpNYnpSUXdGMkFuWmk0Yk1ZVFB2dWsvVkNjdGdvM0R6YVNJZm96Vy85M2Ri?=
 =?utf-8?B?eEx6TlgvQ0o3cERTdURjSnJLcE5iZTg3UmRjTklsL09ucm1xOWNLYXpVQm9Q?=
 =?utf-8?B?VjhZdnZzUnQwaTFtdXgzQytWbHdaZnZXdnJhSHFPM1pkNHdpVTZCOWxma1hK?=
 =?utf-8?B?cFZLNFlpVnRhQm5JNTVhSHlRaTJJMWVzT3Y4NWxtN1NtRm16NDlzSlFUSnds?=
 =?utf-8?B?U3o5QlQzQUUxeVNPYjI3RGkyd3poNlJiZHhQM3RZSU0zYnlFSlBxY2tDVGdz?=
 =?utf-8?B?ZlpnWVEyRFBXYXJzTUp2SE0wWnpmQitsZG4wNUNuby9rOUhkTExJNFVRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6369.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cy9EeldDV3B4dkExc3M1SjhkRk8vQXkvU3plaG9ka3ZXdXN2ZUZldHdhdy9q?=
 =?utf-8?B?cmFuZEJ3Mjh6Tm80eVRnLzhwZ2ZYSUlQVUE2OGIzWWVwT2tZTDVpbTd0Y3Zx?=
 =?utf-8?B?MCtRNU1IbW9zSUF2MWgra0wxNk5HMFJuNVBvZ2NYdE9HNUhHQm8xc2FWUmRr?=
 =?utf-8?B?blA2QThVZ0djMkhMNWZRVGd0S2U5SVhnSHpIdDVXaTFIeDBzelNZSEh3bHlZ?=
 =?utf-8?B?bGxBckN5dHVFc1I2Rm9NRG80TnhoWThXNytCYk0vUzB2VTdmaElaeGpGZnhn?=
 =?utf-8?B?VkpWYTdXL2xWT3VXWU5GQ2NGdzJGcnk3YTYrejNKOTU0RWtXSUIwbkc1UVp5?=
 =?utf-8?B?dzJrVFpETG5VdmtwRTR6cW5LWXVFS2pxMjdwaFdQRGtqOVZhMDlCSWF1RWxI?=
 =?utf-8?B?MkYxcVFvQlBCVkhHYUxtTXNOa2Q0U0ZRdWJaWm5sTlVleE1qUnFVN3A5UklB?=
 =?utf-8?B?SGxPc3AvbFN3Y0M0TVBIbmo0ZENZQjIyTldPdkkwb3VwS1E4Q2JuQU1hRmlR?=
 =?utf-8?B?NkhzeEVBMHF1aXYrZFh6RkJmQnhXVkJBN3JvTkI1bnlLTE54eVJNcDg5Y0k4?=
 =?utf-8?B?WXZYLzV5dlZuWmpvTXJKejhDVWpHRi9sNENBcFJSMUNBL0JUcm1iSzU0N2p4?=
 =?utf-8?B?QlZEU25CNjd0azNmbzNQMURkTDE2SlVicmVOSml3c1NTLzFuY3ZYNmszRnlC?=
 =?utf-8?B?Y1J5ZVhKRHpOY2MrS2RFSllOTjVOUFBsZXNzbmNOc2U2b1c1WFFSUnN5RkNO?=
 =?utf-8?B?d2FjemxCOTRkbGxkY3RQckpqQ3FCZHZPVDVZSG1EOVFpaThJMzkveVg0d1pZ?=
 =?utf-8?B?MDlPUzdSanVaNzlLNDc0TXFIditCdmVOSDVOQVozMHBaUFM3ZEgxNzh2Vjk5?=
 =?utf-8?B?alpWam5pbFo2OUxWdVpjZUVLcFpsdDNpUXRNRU4xcFJ5NUFZNW1vR2ZIVW5Q?=
 =?utf-8?B?NTQ2T29ZWTNlRGt0OG9OL0k5Z2t1MDV3aTYrNC9nc0MwSXZ4WTZHUkdJTzZw?=
 =?utf-8?B?VlQ0eUhLMFN6R2cvNjg3WnNWdXFoRFJTL2NNYkd4d01vYjUyTE1nc0o1czQ4?=
 =?utf-8?B?OG80Q0FwWEFIcnp4OUlXeHlmZU9XUzduK25UKzU5YWFaMElGSTNraUkzbVhX?=
 =?utf-8?B?c1hpWmhacnQ3MmJkNHNRTWp3b0IxOFpUL0YyaWtJMDl4ZzF0YW0yT0g5SUs1?=
 =?utf-8?B?NEtndUR1blBESHhqUlpCQVk4ZDZNNkRPUlBGcjRhNnU3M1lCWmxzQlkzOTZJ?=
 =?utf-8?B?SnM5cjdHODhHN0NnWldmTk54dDU4Q29ic0V6R0JYRlhaYWtpTHY1UXQ2eEN6?=
 =?utf-8?B?cmM4QU10YU5xVm10Q2diS3FEMHVndmtKQmJ1aFhmMFVUY2U2emQ3NWRNbzlE?=
 =?utf-8?B?Ync4SmxMZmhoYktENFBna2UzR00yVHp5UkJKMHhpT2RWdmJVZEw4aGJIVmI1?=
 =?utf-8?B?TFBrN3hxdERaeEpFSE8yVkJVdGxKRG1udTNrRlo5OVNHeEk1ejd4cEZkWFZv?=
 =?utf-8?B?WFZYdXlPVHZxQk9lMFNEM3YvMjJpOFlDTHNIQXA2ZjVId3pHSVZBZEtoSmRB?=
 =?utf-8?B?WEpLT3JFcENwc1lxa3dHMzMyMDFUemxjYTZVbmp0VUl6R3JiUGNiWkhZSldh?=
 =?utf-8?B?OVpUU0t4L2p6bjBGNGY3M0gyZDhrcmY2djQ1cFdiRHBRcXRoVjRuT2NvdHU1?=
 =?utf-8?B?Yll6WHhET09FZllRVXo5TnZzK21UNXVoTGtYYmt2dFNvY0VMMkhVc3lRNDR2?=
 =?utf-8?B?TEJ3Y3Jscy9nVm10TkNaV3VZd3pLTUt5bnJaQS9tTWwrZXZmZFRGQTBZcERN?=
 =?utf-8?B?N2NLOTNwOE1ueVFmREc2Wi9iTyt4aytOMGVXMkZPRU9tZkkxWUQydzVjMXRZ?=
 =?utf-8?B?K25DR2VBQ3R1a1Z4Y2sxQkJ4VnVneW5reUlLOTc4RkhZakxrOHA4Qy9LM0k4?=
 =?utf-8?B?SWdONCtndjFBK3BYSFpvNjE3WHFSV0FhblV4cjMvNzZta2prc1VpSzJQWGtQ?=
 =?utf-8?B?WVpPMWJwTHc2M2IwSkNKcUw0MXlPTGxKcHJjVEEvdmVoci85cEdSTEQvYkVv?=
 =?utf-8?B?cG1aSUFIMTBlVGNram02Y0NzZzFwczVJbzZWZkd2QjZxQ1FFVGxXODB2OTdj?=
 =?utf-8?B?YjZ0ZURjYkYxaGk4Rk00KytTYnJaUmk2VldVU3JTd1pTL3d0T1R0NS9nSytv?=
 =?utf-8?B?UkE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b15b35-7c18-4009-5f9c-08dce934893b
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 14:05:03.2805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: teomlEsWUE+fuHkhLUYXmPN3+tHJcnZPjgW8mSMzp3EATGEaLEktLlQMkkiLER5/DCH/h9fPfAZXNYi3kXh02Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8601


On 10/10/2024 13:24, Matias Ezequiel Vara Larsen wrote:
> Hello,
>
> I wrote some minor comments below.
>
> On Wed, Oct 09, 2024 at 07:05:12PM +0300, Max Gurtovoy wrote:
>> This field is only valid when the VIRTIO_BLK_F_BLK_SIZE feature bit is
>> offered by the device.
>>
>> The blk_size field actually represents the logical block size of the
>> device. It is always a power of two and typically ranges from 512 bytes
>> to larger values such as 4 KB.
>>
>> Add description for this field to provide clarity on its constraints.
>>
>> Reviewed-by: Daniel Verkamp <dverkamp@chromium.org>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>> ---
>>   device-types/blk/description.tex | 34 ++++++++++++++++++++++++++++++++
>>   1 file changed, 34 insertions(+)
>>
>> diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
>> index 2712ada..caa5d13 100644
>> --- a/device-types/blk/description.tex
>> +++ b/device-types/blk/description.tex
>> @@ -135,6 +135,9 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
>>   present. The availability of the others all depend on various feature
>>   bits as indicated above.
>>   
>> +The field \field{blk_size} exists only if VIRTIO_BLK_F_BLK_SIZE is offered by the device.
>> +This field reports the block size of the device, expressed in bytes.
>> +
>>   The field \field{num_queues} only exists if VIRTIO_BLK_F_MQ is set. This field specifies
>>   the number of queues.
>>   
>> @@ -282,6 +285,13 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>>   
>>   \drivernormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
>>   
>> +Drivers SHOULD negotiate VIRTIO_BLK_F_BLK_SIZE if the feature is offered by the
>> +device. When negotiated, drivers SHOULD interpret the \field{blk_size} as the
>> +logical block size.
>> +
>> +If the VIRTIO_BLK_F_BLK_SIZE feature is not offered by the device, then drivers
>> +MAY assume that the logical block size is 512 bytes.
>> +
>>   Drivers SHOULD NOT negotiate VIRTIO_BLK_F_FLUSH if they are incapable of
>>   sending VIRTIO_BLK_T_FLUSH commands.
>>   
>> @@ -319,6 +329,10 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>>   
>>   \devicenormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
>>   
>> +Devices SHOULD always offer VIRTIO_BLK_F_BLK_SIZE feature. When this feature is
>> +offered, devices MUST initialize \field{blk_size} to a power of two greater
>> +than or equal to 512.
>> +
>>   Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
>>   if they offer VIRTIO_BLK_F_CONFIG_WCE.
>>   
>> @@ -879,6 +893,14 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>>   The length of \field{data} MUST be a multiple of 512 bytes for VIRTIO_BLK_T_IN
>>   and VIRTIO_BLK_T_OUT requests.
>>   
>> +The length of \field{data} SHOULD be a multiple of \field{blk_size} for VIRTIO_BLK_T_IN
>> +and VIRTIO_BLK_T_OUT requests, when the VIRTIO_BLK_F_BLK_SIZE feature has been
>> +offered by the device.
>> +
> I would rewrite it as:
>
> `When the VIRTIO_BLK_F_BLK_SIZE feature has been offered by the device,
> the length of \field{data} SHOULD be a multiple of \field{blk_size} for
> VIRTIO_BLK_T_IN and VIRTIO_BLK_T_OUT requests`
>
> Just because people tend to read from more important to less important
> within a sentence but I do not have an strong opinion about it.
> Apologies if I may sound bit picky ;).

I don't have a strong opinion on it as well.

I'm open to making changes, but I'd appreciate getting input from 
MST/Stefan first.

This way, we can ensure we're aligning with their perspective and avoid 
potential back-and-forth revisions.

>
>> +The value of \field{sector} (multiplied by 512) SHOULD be a multiple of
>> +\field{blk_size} for VIRTIO_BLK_T_IN and VIRTIO_BLK_T_OUT requests, when the
>> +VIRTIO_BLK_F_BLK_SIZE feature has offered by the device.
>> +
> For the same reason, I would rewrite it as:
>
> `When the VIRTIO_BLK_F_BLK_SIZE feature has offered by the device, the
> value of \field{sector} (multiplied by 512) SHOULD be a multiple of
> \field{blk_size} for VIRTIO_BLK_T_IN and VIRTIO_BLK_T_OUT requests`.
>
> I think I would follow this pattern in the text below too.
>
>>   The length of \field{data} MUST be a multiple of the size of struct
>>   virtio_blk_discard_write_zeroes for VIRTIO_BLK_T_DISCARD,
>>   VIRTIO_BLK_T_SECURE_ERASE and VIRTIO_BLK_T_WRITE_ZEROES requests.
>> @@ -966,6 +988,18 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>>   for a write request if the VIRTIO_BLK_F_RO feature if offered, and MUST NOT
>>   write any data.
>>   
>> +A device MAY set the \field{status} to VIRTIO_BLK_S_IOERR for
>> +VIRTIO_BLK_T_IN or VIRTIO_BLK_T_OUT requests if the requested
>> +\field{sector} (multiplied by 512) is not an integer multiple of the device's
>> +\field{blk_size}, when the VIRTIO_BLK_F_BLK_SIZE feature has been offered by
>> +the device.
>> +
>> +A device MAY set the \field{status} to VIRTIO_BLK_S_IOERR for
>> +VIRTIO_BLK_T_IN or VIRTIO_BLK_T_OUT requests if the length of the
>> +requested \field{data} is not an integer multiple of the device's
>> +\field{blk_size}, when the VIRTIO_BLK_F_BLK_SIZE feature has been offered by
>> +the device.
>> +
>>   The device MUST set the \field{status} byte to VIRTIO_BLK_S_UNSUPP for
>>   discard, secure erase and write zeroes commands if any unknown flag is set.
>>   Furthermore, the device MUST set the \field{status} byte to
>> -- 
>> 2.18.1
>>
>>
