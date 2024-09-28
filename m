Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6395AB67E
	for <virtio-dev@lists.linux.dev>; Sat, 28 Sep 2024 00:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727482933; cv=fail; b=d1A62Lm7Y/VRBhXH4sNpvTzMugGxuprwnq7goCpEk7UzfviXpP0ElAhjWXU6+gQgg2yfketaf7OvSzki8KziVe3WNh532soAakJI9GU/2tbu5Ta77CCQN1asunBoGs1u3enlniYHV0ujt6agjZrWjWM5CLSjm2PGsDZZdEIWV18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727482933; c=relaxed/simple;
	bh=jobuLubC3FxxyeVqMGKac1dj0p/hdXTKgY1ZwtTsvio=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cvp1VO4R+N8ynEkP0wqlWE7RR6hbLjDWHBw29l5DGEEZf892OwVm/kAlE5L+qvdKqIrb743YA+MFx4/+Yd5WK2VE6v+aKIwZOccwJSSiYqRJkIQW7nr44OYeK/1uHr8rz5cfJa64zq2ErYuyhZAeLtef/qFwXQeQq64gq1VuOwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AnVwogrh; arc=fail smtp.client-ip=40.107.101.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AnVwogrh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfQptWmFLIQ5Z/EWRxs/eylJTh7pyEdumazmlxtNpZTMf+OgZ64Hs+/HnEJ5R0PzKaF0u3UDE9RbVfsxQYKIWv6i04xcaw7yCTUY/Tq0XY06NtT8KnyKi3S2u9C/9EQMoxl15wrsOuWrdwoqImf5UZoCXWxLN0ysrOQjjRA6UxS3SSoYh5KF8U1uNarqoOzXrntiUI7APisjwD737cYK9E+r3FgN36jXEyS1bdJSgoi3f06SX1E1cxlB5bPIjgJox+mL9mx4zOD9zcgI71g6jGfHFNHRA5hTy6iTq7DDuL8f8XRUpXRR0/S8FlIOeioLTO7cwKG33q7slnFeT8NbNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LkQ8xMcS2v1lFwEu2nrPavW9Jk5bZJ7FO3g9fSvyoQ=;
 b=wXCGqsZthXI+7MpksUgcBuFzaqAomwcpFs/7ktlzOUk75EtNeyCtZ998rxolv+kcVZF+7fnWBbvSBmZygxJJt3a2M9zkhWNZFph6cPTEWA785nGQf1M9CiI271a0O27FR2gKlWi3hubcLbeKpQSb0zqEXRv+JgBuCAHT+UffmlF728PPzBf0yyc6jrJ1J7oTYVB9pX9PQI98WJoOQ8mkhrLJbGX5V8ms0PAtZxaZCfPoxzeXOR6RsLbKbNkofNEIEHKwR+zPEWFAUGmfmOcZmsrDZJgbEOVt8rVgMkgIhm+KbhXcnuaIzSGApzJhRZiWv8GI3fx4Uvyx3h3/uOCaZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LkQ8xMcS2v1lFwEu2nrPavW9Jk5bZJ7FO3g9fSvyoQ=;
 b=AnVwogrhJ6b8lBbOXNcYz+r/8lpkmOjmdCZNxQOmZw9I94fmePgABoEEpLsjlZSP9JRKqj0bxSqAFtOrT/PSVvZrDbg3jUO4wKbUk9FD8KRwfbVYqSrQUL6wm0qUsGyuUmm8G0Tg8zIkeItWljo2koEw+VfBrS5P/CBpC4FhnA5fBsZbfltMYVoXgwlUY775vIlypIR/mfqv4elVnPmrJ1++j/z8tmtNwoLuEhQlMcuTGaWw1r8DQYbDNdq5x4ZawBy6sPPCOrE9dEMbzZvn3tjFB52JCTqV5HSu2HskrcgRQUhP/TuIosJq/b7kAaquZtWDNRExPMEQWTs3QSi9Qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by DS0PR12MB7511.namprd12.prod.outlook.com (2603:10b6:8:139::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Sat, 28 Sep
 2024 00:22:07 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.7982.022; Sat, 28 Sep 2024
 00:22:07 +0000
Message-ID: <adf195c4-6d7e-47ff-ac62-dc4c0f463f21@nvidia.com>
Date: Sat, 28 Sep 2024 03:22:01 +0300
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
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <CABVzXAma4T+=meTSRNKhq70w4imc=A5imy2zofX2ndJz-XVByg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0266.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::11) To CY5PR12MB6369.namprd12.prod.outlook.com
 (2603:10b6:930:21::10)
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6369:EE_|DS0PR12MB7511:EE_
X-MS-Office365-Filtering-Correlation-Id: 34f66a69-5b27-4567-74c2-08dcdf5395f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eHU5WTNhdXRpMDNDUmVHV1VSbUthRVBkRUdTUzBDNHZYMUthMEt3em5WUW95?=
 =?utf-8?B?RmJUbVkycHgyWjBPVWI1eVR3UVQ0VURqVjkwN2o5bzBORWVVckpFQ1lPcTJM?=
 =?utf-8?B?cVJUWTZxMVp6SEFBZ253OGNwajBXVXhMNjVQa1p4cVFzMDZldlNvVzdyZ2tQ?=
 =?utf-8?B?d3RGQkl6b2JRVVI0SzFpWWFtdVhDV0VvYkpYbXRoMm51SFF5Nlp2RXJLL0Q1?=
 =?utf-8?B?UWpUTWVRWnplSG42NWErWVNDdXpjWi9JcEd0a1B6bVlxVkZGSG1nTXZ4aWlm?=
 =?utf-8?B?T2FJbThUSDZ2MkF3NWs5c083TkFEei8xY3ZqcXl2eE9jV1J2M2xtYUdud1Qv?=
 =?utf-8?B?MUVhcWh2QmZkRHhzZ3NTNG1jMmRyV0tzTmt6dXBGSTM3dDZCZlF1THBWeDdh?=
 =?utf-8?B?dEFZaytlWldZMldQR081eE04ZFlFemZjdTV3WDErRWdMUXZwdUU4QjVpVG0r?=
 =?utf-8?B?Z3BkRStJOG5ad09Oa2ZHRW1BdDc4WjdQWVdqaXQvRENueTQyMHB0NmxMekM2?=
 =?utf-8?B?WTdpajQ0azB2dGV6dktRZUo4eG9lWnhDdDlTa29JRllxSXN0V2cybXJiT3Ro?=
 =?utf-8?B?MjF4MWRMZnI3QVJVdXRxR2ZsNGk5eHZyTlNiaHBGeW9DVUJiNVpPa2VxeWpk?=
 =?utf-8?B?WEhaUStzbnljYXAzcit5RWcwNENMcjJqdjBPN2VGWG55ZVVmSzRmbWRVZ3dx?=
 =?utf-8?B?MmRqQlNDYmo3WVloRzQrSFB5Zk9tWVZQRUgvd3lOZVJ0RkErRUFNQnVoS3l4?=
 =?utf-8?B?clB4ZVlKUTdhNFZoZUtGM0dsMDVDdnVYVWFTWEFsMllRcFpBaHNBSjNtMzNS?=
 =?utf-8?B?bExRWFovTWxVTUpxdWxHRVlERFdBa1FHd1dYNVArL1Bqdlp6OUIvdTN6amxo?=
 =?utf-8?B?VjZGM0F1QjQxRFovcWZMTy9QVTUzTVNsa2s3MjBrNmUxcjM0Ny8yU21peFJy?=
 =?utf-8?B?L2YvOFJ2bmFDOHdQYUlKcnlkZDNoeW5JLzUwdDI2aGJMaVpyY3FtU1dPenJs?=
 =?utf-8?B?UDVuWU5mVnRQWVpBVW9wdmVmeXdNL2NUa3FqS3E1N0ZzL0E0MlBSUEthZllz?=
 =?utf-8?B?Z090TGRiSzh0eW9wTzR4Z0ZQV3R1Q3FYcTF3NGVEZ1lmVmNvUHYxT0J4NXVz?=
 =?utf-8?B?NS9yRWE3WklRVnkzc0wydTJJMEgvL0JjZmVLTmJYcWNoSnFrYzh5N011WUw2?=
 =?utf-8?B?YUswQVA0ZTNVMnB4cUVKZlIyZHQvb0ZjZGhXZ0pBVXR6WlpWZ0lUYWh4ZTBv?=
 =?utf-8?B?d0NrZDFKTjRRWm4wRVR3UzMrZThYeXNzZDRGNTk3UkpYUmNRODZKbEJlak9J?=
 =?utf-8?B?bnpuUnlZZ3VDd25BekZqS2RhLytYckt6cnNzdGJaRGlmKzVVR2d4R2pnWmpU?=
 =?utf-8?B?MUdETTM3clY2MGFmc3YzdHBteVlxbTFqNjBWOTZmL1dKZnEvODZVNW9qV1pu?=
 =?utf-8?B?WW1YM0lDZjFRRmlxWXNRVzhiU2Y1SDNvUWgxZSt4LzZWVVU3TGc5a0xlZHpL?=
 =?utf-8?B?b3FuTzlET0c3Y0dtK29sc1Z1SkxuN2NIU0VZVHVwa0IzNjRUOXA2T0FWMDNh?=
 =?utf-8?B?Z0VNbjYrTlk3bGo5bm9SaTIwVzQvczNMbzVQZDJqWGthYkxrYk5UdnFhRzZs?=
 =?utf-8?B?ZE5USS9UTHM3aWUzallmL25UYm1XY2VnTnVpZ2FIK3RhWFF1OUVheDVZVWNn?=
 =?utf-8?B?aWM0aS8xdFZpOXc4Z1VIZG9EL0toNjVYdVNyV0dXRjFCNmxDWFloUERGUEdv?=
 =?utf-8?B?OFFkNTdWRnpuc3VyVzVGWWZWa1B2dCtFd21hdnRyRFVsdDA1RTF2VEFud1JW?=
 =?utf-8?B?UmEwY3QvZHJSVm9PK0ZwUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6369.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THhuT0w1N1pJeWErenlRM2NyUG1jbnJYMEQ0am9Ba0hQd0RGd21vNXNEM3lj?=
 =?utf-8?B?THNSUmhXSGJkUFdXRXU5VHA4REZ1M1NyYmRiREdpbmJ2WXJXaDZGNnpqUXBt?=
 =?utf-8?B?U1VTZ24zUXNhUDVsN2w3YXVzQWVpeGVqd2FvWUxBb1lFQW1DSC9SRkhjWjNo?=
 =?utf-8?B?by9WNWtEa0M2bW1rZy9MdzAxelFnS1FuMXFyWE5QaDBzSHFQNDBROFg1WW96?=
 =?utf-8?B?NzNiZFJDVGZSeWZHTmZ3S0pQSlFHbXp2Vk4vNmlTbGN3bnVvS0lweE40Kysy?=
 =?utf-8?B?RnhTOWVDVVBSci94Z29UZnprTVFaWGluRVUzamZQVGcvWmtYQkFwRVRiME1N?=
 =?utf-8?B?ak0yUjhKUlBEdG1mcXE3NktodUd5bGlRS0k5S2k5ZXNySFF3Snl5Q2tManBV?=
 =?utf-8?B?ZkZIQzJHZ3d3ZFNuOWVKOTdqRnpxcnUzYjc5Z3E0dHBwd0lZeG0wU1pMTXpw?=
 =?utf-8?B?ZFFTaHdoc1JpMmdWZ2lPRmN5N25qc2pzZnJ5QUYxeUZRNlpSK3FjMTlvaFlN?=
 =?utf-8?B?dng5NlFqR3RXZDRMdWZKN094cGRjS0lTWGxoZ1RqOHBlcTl5TU9iK0o1ZEda?=
 =?utf-8?B?SUloejZjeGJxNXh2c1RWWVlrKzRpb250M2JTVnZJeEVDMUVIV2NoMlZ3V3V3?=
 =?utf-8?B?WmFhMVdlR2JJYkN2RzB5R3NzRUFCdFArOSt1TXh3R3drSWFqcVAwR1IwVnN3?=
 =?utf-8?B?Ny9BK1d4K254RXNOcWo1TWcwM0pUODJGdGRobTFEbTNLT2RvOHJldzRVRldY?=
 =?utf-8?B?RUNoSlltWjgxa1E2LzJxaS9FQytFTTJmSXhpVTFHWi82U1A2OGlQbGJTczBY?=
 =?utf-8?B?bGljSkl5SVh1M3UrMmdydGx6Rkl3cGZKYVZaNG1DMlVYN3RkcU5JVjZPKzdB?=
 =?utf-8?B?L2YvNGw3ZTBVVU1BZWt3WWJ3ck41L1Z3WlB4VDEwdFd2bGxQV1NyWmNVOVVx?=
 =?utf-8?B?K052QW93c3BUMXMrUFAzVFU0T001em05Y2JHQ25WMi9WSTNTT3dPVlZNYmdh?=
 =?utf-8?B?OUNBUVBmeWRkWkdTN21BRkYwZmtYMlZ0ZExmZUZrU2ptQjd5OXJZa24wNXBt?=
 =?utf-8?B?TXhXRVFvclZpWElOVU9GZnluLytWYjZVWGd4MVdGU3dsODl3OUsxMVI1a09r?=
 =?utf-8?B?TjdpNEl5NmpqdDVJMzV2OTV5NkluVmprK3RYKzd5c3l6ZEY5WktJem95OFhp?=
 =?utf-8?B?eXlCaEYvYWRpbE1rNXVWQ1crTThOazVCbUJ0NmJzQ0lCQVRaU05JL3RoUlBt?=
 =?utf-8?B?aTNZMGtMUlNkajh6ZDFDZktySjM3V1NiUEFUdGpCb3Z2cTlsQmFaSVZvd0pE?=
 =?utf-8?B?YUNjZnN5S1lRRVZhV1N3SXptNkFqdHFVSk5XWE1Femwra2p6WUhDeXVHcGJm?=
 =?utf-8?B?bXp0QmhCdWhEZ2Vud3pZaXlGUkNmL3UxZHE3b3NZWENiT3dHK0N0V0NFRU1k?=
 =?utf-8?B?cVl4WFIwVHdTK2M0YTdaVEJ3dW85ZW9SQzZ1NkQwTzRKT2ptSGw5dThTck9i?=
 =?utf-8?B?dWJXanRmVWt2Y1RNM05tSFRldUVIQXVGTHA2UnZlRndCRVZhNEtpZkttdmwy?=
 =?utf-8?B?ODY4UjkveGxPVURkTmcxY0tCWUFyV01ZWWQ3dWd4SVNHRytXTzhOTlE4aC9o?=
 =?utf-8?B?TS9jOWRoVXZMUjRqQU41VGtxNlBOcjFQeFVIT2NYajF0VXkxTnZLSmdlUlNK?=
 =?utf-8?B?TU1XZWVwYkFwMjV5SGFIbnlFN2ZRL3l3MzJQSDVRZjhmdUNoVkhWQmhYTVYx?=
 =?utf-8?B?eHZMdjRQTUlpM3RydysxZ1NXT3N1WW94d0NNaENDWlYwNU5Mam5KZjNwWlZS?=
 =?utf-8?B?eExiQ3V0c2JGVlNzNHF5Z29vNjVEZTZDT3o4a1JlSzZlU2toV1R3YzNac05m?=
 =?utf-8?B?RHoxZnNkTkdhMms4N2R3M3cxYkhzazJIdzluMnZFOEo1L3NSalVyMEZncXFv?=
 =?utf-8?B?QWFmVm8veGhXSmlLRGJCanptZmlPWEJsK2ljMnF2ZCtCN2lZV0h4MGFvMjd2?=
 =?utf-8?B?YlphamVjRjBpMTR3bnU4UWwxMFRRSUFRZXJXc0xQWlFUYk9ULy9xMHp5UWNY?=
 =?utf-8?B?cko2UCtYZG9JZWwybU1lSWlETm1XNnZ6bHU3cDNkRlN4blNsVEJFVnIyY0Nz?=
 =?utf-8?Q?SgIjGgowA8tgn/7Zb67fqti8O?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f66a69-5b27-4567-74c2-08dcdf5395f2
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2024 00:22:07.3614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 13AveE8wrk2JVuYKjHI3r347Xs+rLkUAKqHP9SSd+PoQXqOJQUBYQylYolqruIyXlgCD0uomnog8tm2wZJ4o/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7511


On 27/09/2024 0:44, Daniel Verkamp wrote:
> On Wed, Sep 25, 2024 at 4:42 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>> Hi Daniel,
>>
>> On 25/09/2024 23:57, Daniel Verkamp wrote:
>>> On Wed, Sep 25, 2024 at 8:05 AM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>>>
>>> This field is only valid when the VIRTIO_BLK_F_BLK_SIZE feature bit is
>>> set.
>>>
>>> The blk_size field represents the smallest addressable unit of data that
>>> can be read from or written to the device. It is always a power of two
>>> and typically ranges from 512 bytes to larger values such as 4 KB.
>>>
>>> I agree that this is what the blk_size field probably *should* have
>>> meant (matching other storage protocols like ATA, SCSI, NVMe, ...),
>>> but I believe rewriting the spec like this changes the meaning of the
>>> blk_size field in an incompatible way.
>> I believe that this is more of a clarification than a re-write.
>>
>>> Previously, blk_size was described as the "optimal" sector size, so it
>>> seems clear that the driver is still allowed to send requests that are
>>> not aligned to blk_size ("awareness of the correct value can affect
>>> performance" but no mention of correctness). A device may need to do
>>> extra work to support this, of course, such as turning an unaligned
>>> write into a read-modify-write sequence if the underlying storage
>>> device doesn't support such an access directly, but such requests are
>>> still valid. It's also perfectly fine for a driver to ignore
>>> device-offered features like VIRTIO_BLK_F_BLK_SIZE and still operate
>>> correctly.
>> A device should report its block size (logical) using the VIRTIO_BLK_F_BLK_SIZE feature. For legacy devices that don't report this feature, Linux assumes a 512-byte block size.
> Sure, I agree with both points here.

Great.

So I guess we agree that blk_size == logical_block_size.

>
>> Drivers should not ignore this feature when it's offered by the device. It's crucial for correct operation IMO.
> This is a "should", not a "must", though - adding a new MUST is a
> breaking change.

I can change it to 'SHOULD', but this modification has implications:

1. drivers that ignore the VIRTIO_BLK_F_BLK_SIZE feature will make 
assumptions about the logical block size.

2. Incorrect assumptions could lead to undefined behavior.

I'm ok with 'SHOULD',  since it's a strong recommendation for drivers to 
negotiate and respect this feature when available.

I'm not really familiar with drivers that ignore this feature so I won't 
argue here.

>> The statement "driver is still allowed to send requests that are not aligned to blk_size" needs explicit clarification in the spec.
> It definitely would be better to have it written out explicitly, one
> way or the other, no disagreement there.
>
>>  From my understanding of the spec, the driver is not allowed to do so (otherwise error will be returned or the behavior is undefined).
> This doesn't seem to follow from my reading of the spec. Otherwise,
> phrases like "optimal sector size" and "can affect performance" would
> not make sense (such a request would instead be described as
> illegal/returning an error).

Is it possible that certain parts of the spec could be improved ?

Is it possible that certain implicit parts of the spec could be 
understood differently by various implementers or users?

In reality "optimal block size that can effect performance" probably 
refers to logical vs. physical block size.

This patch tries to make the spec clearer.

>
>> In Linux, the reported blk_size is used to set logical_block_size, while physical_block_exp is used to calculate the physical_block_size.
> Sure, but this is describing the behavior of one driver
> implementation, not really relevant to the meaning of the spec.

It is relevant IMO.

It's worth considering the historical context of the specification. To 
my understanding, the spec was initially derived from the Linux 
implementation, rather than the other way around.

This translation from implementation to specification could have 
introduced some inconsistencies or ambiguities.

Also worth considering virtio-block devices that were implemented before 
this feature bit. The WG probably tried to maintain backward 
compatibility with these devices.


>
>> Regarding the specification statement: "This does not affect the units used in the protocol (always 512 bytes)":
>>
>> This likely refers to how certain fields in the virtio-blk protocol are expressed, not the actual logical block size used for I/O operations. For example: capacity reporting, max_discard_sectors and Other fields that are expressed in 512 byte units.
> The way the fields are expressed in the virtio-blk protocol is what is
> relevant in the virtio spec. Even if a virtio-blk device is sending
> requests to a physical SCSI/ATA/... device behind the scenes, it's the
> job of that virtio-blk device implementation to handle the translation
> and whatever mismatches there may be between the protocols.

This is true.

>
> Particularly, the "sector" value in a virtio_blk_req used for
> VIRTIO_BLK_T_IN/VIRTIO_BLK_T_OUT is always in 512-byte units,
> regardless of what blk_size the device reports, and regardless of what
> underlying physical media may be used.
>
>  From the virtio spec: "The sector number indicates the offset
> (multiplied by 512) where the read or write is to occur."
>
> (This could probably use clarification that the "offset" is in bytes,
> but it still seems pretty clear that it does not depend on blk_size.)
>
> So a request with sector = 1 always means an offset of 512 bytes from
> the beginning of the block device, even if the advertised blk_size is
> 4096.

I appreciate your perspective, but I disagree with it.

When a block device has a logical_block_size of 4K, it's not possible to 
perform read/write operations at arbitrary offsets like 512 bytes. The 
smallest addressable unit is the full 4K logical block in that case.

This is a fundamental principle of block device operations, not just an 
optimization.

Also IO granularity.

I believe it's important to ensure that the specification accurately 
reflects these fundamental block device principles.

I believe that the reason that the "sector" is multiplication of 512 is 
to maintain backward compatibility, and not to allow breaking these 
fundamental principles.

>
> This is different from (e.g.) a SCSI READ where the logical block
> address is in units of the block length returned by READ CAPACITY, so
> it is impossible to send a request that is not block size aligned.

IMO, it is impossible for virtio block device and any other block device 
as well.

>
> [...]
>>>> diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
>>>> index 2712ada..88a7591 100644
>>>> --- a/device-types/blk/description.tex
>>>> +++ b/device-types/blk/description.tex
>>>> @@ -3,7 +3,10 @@ \section{Block Device}\label{sec:Device Types / Block Device}
>>>>   The virtio block device is a simple virtual block device (ie.
>>>>   disk). Read and write requests (and other exotic requests) are
>>>>   placed in one of its queues, and serviced (probably out of order) by the
>>>> -device except where noted.
>>>> +device except where noted. Each block device consists of a sequence of logical
>>>> +blocks. A logical block represents the smallest addressable unit of data that
>>>> +can be read from or written to the device. The logical block size is always a
>>>> +power of two. Logical block sizes may be 512 bytes, 1KB, 2KB, 4KB, 8KB, etc.
>>> Does this imply that a device may return an error for a request where
>>> the sector or num_sectors fields are not aligned to the blk_size? If
>>> so, it should be called out as a more explicit normative requirement,
>>> but that would definitely be an incompatible change.
>> As mentioned, the logical block size, such as 512 bytes, defines the smallest addressable unit for I/O operations on the storage device.
>> This has important implications for I/O requests:
>> 1. Minimum I/O size: You cannot send I/O requests smaller than the logical block size. For example, with a 512-byte logical block size, requests of 128 bytes are not valid.
> 128-byte requests are not valid, certainly, but that is already
> covered by the wording in the spec ("in multiples of 512 bytes" in the
> VIRTIO_BLK_T_IN/VIRTIO_BLK_T_OUT description, and "The length of data
> MUST be a multiple of 512 bytes for VIRTIO_BLK_T_IN and
> VIRTIO_BLK_T_OUT requests" in the driver requirements).

I guess I should have given 4KB logical block size as a better example.

In case logical block size is 4KB, the minimum IO size is 4KB and not 512.

Agreed ?

>
>> 2. I/O alignment: All I/O requests must be aligned to the logical block size. This means the target start address (on the media device) of the I/O must be a multiple of the logical block size (the expressed units in the spec are not relevant).
> Unless there is a change to the spec (like this proposed patch), I
> don't think this is required. I suppose a device that can't manage to
> perform a misaligned I/O could choose to deny such requests and return
> VIRTIO_BLK_S_IOERR, but this is not explicitly allowed or denied by
> the current spec.

This is a clarification of the existing specification, not a change.

I believe I've identified the main point of disagreement regarding this 
patch:

I believe that I/O operations to storage block devices MUST be aligned 
to the logical block size. In the other hand, you believe it is just a 
recommendation for virtio block device.

Maybe let's see what others think as well ?

Stefan ?


>> 3. I/O size granularity: The size of I/O requests must be a multiple of the logical block size. For a 512-byte logical block size, valid I/O sizes would be 512 bytes, 1024 bytes, 1536 bytes, and so on.
> Same as point 1 above, the only requirement (that I can see, anyway)
> is that the I/O request has to be a multiple of 512 bytes.

Do you think that for logical block size of 4k one can send IO of 1K to 
such device and succeed ?


>
>>> The "smallest addressable unit" wording is also more confusing than
>>> clarifying here, since in virtio-blk, the "smallest addressable unit"
>>> is always 512 bytes, regardless of blk_size (even if a change like
>>> this would enforce limits on the sector values that would actually be
>>> allowed, it would still be possible to create a request that refers to
>>> a smaller unit than blk_size, unlike other storage protocols where
>>> logical block size changes the multiplier of the address, making it
>>> impossible to address smaller units).
>> Can you please point me to the place in spec that explicitly say that "in virtio-blk, the smallest addressable unit is always 512 bytes, regardless of blk_size" ?
> The description of struct virtio_blk_req's sector field:
> "The sector number indicates the offset (multiplied by 512) where the
> read or write is to occur."
>
> Unless we have different definitions of "smallest addressable unit",
> that seems pretty clear. It is always possible to address a part of
> the disk in 512-byte multiples (e.g. sectors 1 through 3) even when
> the blk_size is larger than 512. Maybe those requests won't succeed,
> but it is always possible to describe a region of the block device
> with an address that is not a multiple of blk_size.

It doesn't say anything explicit about IO alignment and granularity.


>
>> I didn't find it in the spec and I don't agree with this call if it is implicit.
> I agree it should be clarified. The current wording requires too much
> reading between the lines.
>
>> The implementation of the Linux kernel driver isn't implemented in this manner as well.
> When filling the sector field, the Linux virtio-blk driver uses the
> value of blk_rq_pos(), which is also always in units of 512 bytes, as
> far as I can tell (it returns sector_t, which is in units of 512 bytes
> per the definition in include/linux/blk_types.h).

Ignoring the units for the discussion, can it ever be unaligned to the 
logical block size?

>
> [...]
>>>> @@ -228,7 +234,7 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>>>>   \item The device size can be read from \field{capacity}.
>>>>
>>>>   \item If the VIRTIO_BLK_F_BLK_SIZE feature is negotiated,
>>>> -  \field{blk_size} can be read to determine the optimal sector size
>>>> +  \field{blk_size} can be read to determine the logical block size
>>>>     for the driver to use. This does not affect the units used in
>>>>     the protocol (always 512 bytes), but awareness of the correct
>>>>     value can affect performance.
>>>> @@ -282,6 +288,12 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>>>>
>>>>   \drivernormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
>>>>
>>>> +Drivers MUST negotiate VIRTIO_BLK_F_BLK_SIZE if the feature is offered by the
>>>> +device.
>>> Why is this a MUST? This is also an incompatible change since there
>>> was no such requirement before, and drivers are free to ignore
>>> features they don't care about.
>> I can say SHOULD, but then the driver that is ignoring this feature may guess/assume the logical block size and it can be wrong.
>>
>> This may lead to an undefined behavior.
> Unless the spec is changed, if a device can't correctly handle
> non-blk_size-aligned requests, this seems like it would be a device
> bug ("undefined behavior") or at least non-spec-derived limitation
> (returning an error would not be undefined, but also probably wouldn't
> result in a working system).

Again, this is a clarification of the existing specification, not a change.

IMO, storage block device implementations should be able to assume that 
I/O requests from drivers are aligned to the logical block size. If a 
device receives misaligned I/O requests, it might be appropriate for the 
device to fail these requests. It is not a device "bug" IMO.

I'm curious if you've encountered any actual implementations where 
drivers send non-block-size-aligned requests to block devices. I never 
saw such implementation.

Sounds like a theoretical objection.

IMO, the specification could benefit from explicitly stating this 
alignment principal, which would guide both device and driver 
implementations.

I believe that this patch is clarifying important points and would lead 
to more robust definition.

>
> Certainly it would be preferable for the driver to send aligned
> requests, but the existing wording seems to cover that pretty well
> already.
>
> Thanks,
> -- Daniel
