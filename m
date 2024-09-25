Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2053.outbound.protection.outlook.com [40.107.102.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71D91A3BA6
	for <virtio-dev@lists.linux.dev>; Wed, 25 Sep 2024 23:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727307753; cv=fail; b=m+IzcvKRKUpdMnmqtiHTXqIK8/mUwOgUTbYuHcgdvrURAXGqslXTmyfNy9BYHrYHQnI/+qmXAJL7cC5XAdFZaAO3BcBtpHyn1LH85cE27KZSTfaLo2Vwr09h60tfoYWTfR5+aeM1IIuze77CenzNK6xjh/RMEFOZpFsevtUa+Ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727307753; c=relaxed/simple;
	bh=1nY57XtiKa1XJTc9VKHRQ4noNj8BUrEhJfHiqu532fM=;
	h=Content-Type:Message-ID:Date:Subject:To:Cc:References:From:
	 In-Reply-To:MIME-Version; b=DXgTwfXCsEia6FeuLesYDx9T8KRG6GZhsKoUFLDzPvMoD0XvKjLs36ZQ3mMKbAa7zCR/d09PH+zqxqYJtFf0x0Nk+yBq2GcN/wAhBaLs3JKGZ7RD4j9XrMOiguOQdPgl1FidkPfY4DGs/vEsW625zy0HJUoefBYmoYrb/cJX3lQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tvi1idY/; arc=fail smtp.client-ip=40.107.102.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tvi1idY/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TlV1JH0713cvI7T595pvuJrtwVaz4pVLGTCfmEFO/HV63+0sZdQgdF7QUcuwyblsMgFConTmDZezo0PiqnMzbPt46W0MWT44pwgYHObb3rTZQYMqKb0WNsiOIA6fbUL3PGLFBCbtc3s3o+PnBdtA9yYGMKnStc4VxyAdLs37f6BOqD9yz2sAHWGSvpNOmYT/MvNjnH3lKWaV89o+1sZ4H+BJkBBta9pijvbaGrAZ54uxpKr4KcvW46kIl9TApOX8zLJ1mMA4Pdmv/chUOVUEz5uoS71He3bLXPu7YMEp4cJHUOUuZVTjbHXmk4t87AlxZN6SDN7gGgarRm+4Pspagg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFrxd9PyWVPEhVMqupqEIdV4Otdv+l3zBrstlQlASik=;
 b=GCJKa3DqRmoz8B1O/OCksbJ2xi6arx4xzkOJV7gMFkOUWLF2izNshjhMlnJe/3yyCizoov+AZwk62AAvoM78VHI9xNhCJJlDKNs8u05/MEhl6WiBLNr3YIjHEyDbzX3y9m7UHDGcJmOPxy80cEFFXclSRrTvOcQKe3o1iJ+P7HLOjtUrIiLMQmdGMgyg4J2h1p8tPgUqyxzGG3iw6RNvCrqIjGeWPF76aUuOUnuQhyK9RANYb3yEnciZGB9uiOnLu/eNqhhx17PL9kLc5mYtIKX9rSK5ac+nGiGzkuWn8qfr/w9LGMoNYn75ENq2kWgwQwKhgL7AGnL/DvyNIXUAwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFrxd9PyWVPEhVMqupqEIdV4Otdv+l3zBrstlQlASik=;
 b=tvi1idY/35OMgi3sIKmb2csBSXbwse8ytO5PJ4/m+VvNersJ4vKJCXtS2jU6ZNkCikSicBLhq95nrhF0AX7lIt7T6IUYMk4lYECOTyBxeuTWOOd/rbnBL0wfLeqlkz1IA8gE6oZVn2EMQECDbbYMfiy56HPXh4MlBhkF2Rpzu42qSmnhfHbXYJCPtrIeXBztU/QM2swAf/a3VseyZ8UI+YD+X0iy/SomRNUtE6fBF+FwQqpek2C7QRMreXh2GOy+ms8xJMqT3CwKP4CnfzAji8aAQDREyDsiLkapTOzEEVzQkufE0Rp8xZy67lYtmltsl2DErJbZal0rZ80cnMbKAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by SA1PR12MB6799.namprd12.prod.outlook.com (2603:10b6:806:25b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Wed, 25 Sep
 2024 23:42:26 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 23:42:23 +0000
Content-Type: multipart/alternative;
 boundary="------------MIFCgvRqhTe8CcUZx9fSnSbY"
Message-ID: <ca954af2-4c61-41f5-8cf0-69a1233704ba@nvidia.com>
Date: Thu, 26 Sep 2024 02:42:18 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] virtio-blk: Add description for blk_size field
To: Daniel Verkamp <dverkamp@chromium.org>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
 stefanha@redhat.com, virtio-dev@lists.linux.dev, oren@nvidia.com,
 parav@nvidia.com
References: <20240925145228.27953-1-mgurtovoy@nvidia.com>
 <CABVzXAntBt+5L4a1ntud_7j_EHiB4yG6FuskNaPBirOfLJ7i6w@mail.gmail.com>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <CABVzXAntBt+5L4a1ntud_7j_EHiB4yG6FuskNaPBirOfLJ7i6w@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0641.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::7) To CY5PR12MB6369.namprd12.prod.outlook.com
 (2603:10b6:930:21::10)
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6369:EE_|SA1PR12MB6799:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dd939ef-5963-4f83-e7c2-08dcddbbb442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TURKVm95bjNPSHFhMVc2OW5rSnlBeTJwQmhkN2ZKeXE4Q3pQODhrcXFLM0Ex?=
 =?utf-8?B?QXh2eGJUWERFRXFEVGpDWXhwZXNHc0ZwWFFwbWMrY2JLcTRFYkl4M01PdXdX?=
 =?utf-8?B?TVd1QThOV0Q3UXlKSS80UDNsTld5SWhOMHYrTjVPRHltbHlrR0d3K2llZWwv?=
 =?utf-8?B?LzdScFZNdHFDSno4UWljSHNuWko2S0g1dWVSMDdIaWZxdmhjbWdKUGtBTHlI?=
 =?utf-8?B?NndvWWR0VTAvOTBJc25hUExoR1BtdFY5MXMvUS9pTWoyOXJOZHMyVzcrMVBI?=
 =?utf-8?B?cTlzQkN0dGx1TUZlQmdYMUFUaWxWL2pUZ25NMmRLTzJTTEFIelhrekU3dnRQ?=
 =?utf-8?B?Slcwb1pRR0dieHpSbWdOSXJtZDcxMWk0bjFjQVVjV1hkbXlQWldxSTkzM0Z5?=
 =?utf-8?B?bHcyUDZSSVkxcUJSbGl2b3NlTWd2c3pBMTFkanVybUhGZjRnSXBiMjRUTThu?=
 =?utf-8?B?THZXM1pjaVRUNFl4SVdDbm5pKzIvR044VkFjQ3ZyRys5N1dLY3VlR0xIaWYv?=
 =?utf-8?B?eHJYV20rREhxNHorTjBuelFoRzI5aTJqaFpqT29vZFJzajhlVWxrSmgxYVRZ?=
 =?utf-8?B?YmFuQWdvVE1JbVBkRUVMYWdaOGFZMUZQMXJTN2NuMnAxM0FaNXZaNGFTVDRq?=
 =?utf-8?B?dS94eWV0MkV3S0dkRGViVGNrbHdsUGNRSVpjeUV0LzMxaVJ0TEs1WVE1TUxB?=
 =?utf-8?B?clNOczFhdm1LTnF0dzhGZGxqQk8vZVhYcGdMOHROdzNGU3FCNWtYVXd5RFcz?=
 =?utf-8?B?RU1HajFHYkZnTVpjM0ljQ21zNEMyZzlpanpCWlVUdVFUZWRtQWpPUitVR1ds?=
 =?utf-8?B?dUh0cVVFU2NNejA0OHowdDlhMjFTSHR6WThlZ01ZaVZVQ0hhbmFSM0xCWnBp?=
 =?utf-8?B?b3kxL2RkRDVpeTNhVTJLRitJVG41WGxBV1VsSVhjZUJ2SlhqWlR3aVVXTldP?=
 =?utf-8?B?emI5OUZORmxJS0hEMFZZQTlZYUd4WHBiMWRBMzdRVERGeXNwb09PbkhmZVdN?=
 =?utf-8?B?RzE2OW44V2VwVE1tZjVEN09Wb1FKQVY1ZlFhVHpXV1NyY0dLUjlYQ2JMLzh3?=
 =?utf-8?B?QTBHdUIydUpFMnNsa3k5bExpUXNudnV3L0xIZEZ5aW13UVFGSHd4SitmM3Fo?=
 =?utf-8?B?SjUxMFV1MlkzUnVBbWZCRmFySU9iZnBQd0daaEVUVjNlRGp2V0I2akdOZ09P?=
 =?utf-8?B?SExsRDhZWUVxcldjdEt3dkdyNC9Hd1ZsaHBpTGxkQUdSRHhhOXc2b1FDaXc2?=
 =?utf-8?B?YlRENWFhMERHdFJ3YlZ2ZW83NnNscFAvUklaa3VIeEIvRHF4MitybkZrSUNX?=
 =?utf-8?B?eW9DYmthTS90NXVRTU9NTTlKME5YRURHazEzVm9KYUtXeGUxTzg2RkZ5cDJa?=
 =?utf-8?B?NXJUTHZ0ZGtyYmpCaVljZng4d2xGSE00ZngyVEJzeVp5NlpMNWJrSzBFWDZu?=
 =?utf-8?B?STFLYitOUERLUURJV29JY3ZuNXVaQitsUDdMeFoyTER5b0VTSm93OHNobjZF?=
 =?utf-8?B?ekFoN3FnTXh0UzIyU1N5MmVuV2d3enNZU2lGMzJEaEdGRzh3UzBKNkZ3T2ZK?=
 =?utf-8?B?cHY2K3hFR2Z0M21OWUR0MWxCQ2ZWUEswMlduRHhHTHVqU0pSVExMelNUeVVq?=
 =?utf-8?B?N2FMRnROK1ZCWlVKSFBVbk8xVFZIejRxSCsra2h5QjVOTkFZUDgrUmdQZ2FM?=
 =?utf-8?B?L0RyRHhrdklCckxkWk0yOEsvdzhXV2Y2akpULzZHZko1WENLNUF5dEtRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6369.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ym10T1F3MnZiZmRId2dHekowclJxVTVQbDFVSGhqRm9PM2ZPOUlkSVNrYnNS?=
 =?utf-8?B?bGtHb3BJalpiODJUVXRRalhXaDY5UGVBUW56Y3VRZ2IwMjBQTWgyRjNvVnFO?=
 =?utf-8?B?d3JwUXUyS082cDlSeWlRRVhyVTcyRVMwNjBpSHZtd2ZRWkpubnpXbEp5a29Y?=
 =?utf-8?B?MzUzakF4NCtaSEh3aURxaFpIT1NDWDBLVlljQW1NRCtnZDhDRVZFQzJ1SVdp?=
 =?utf-8?B?d3hwMU50cTVxaWJxa0ZGZkkrT1FMTUNUN01oTGhSQmhSN1J4ZjV3M2h0UGFp?=
 =?utf-8?B?U09WVWxHV2tSRTVSK01KZ2VDa0o4REh2eFNGM2lMOWN0aVlJNnZ2V3JRK1kz?=
 =?utf-8?B?bldMTjBpTmwrcm5ndGtudTRmTlVVOE9WWU9tMmQyNnpoYmswak8zQVRQWHQw?=
 =?utf-8?B?SHkxODdvSXdvRnFrNGdZVGU4S3BtOHRUSkIyYWN5aDR5SWJ6a05hQVQ2TFEw?=
 =?utf-8?B?TjAvSzBQbzhpMXBiaS84U2RRcFZ5RTZvOFZaUHQvQng5bVg5MzI3Y21TSkdi?=
 =?utf-8?B?N0dCaFAwQ1Rwb21lNmhoMDBpMWxoK3BaWGJDZDQ5elNBQ0hjWUlGUlV5R3o5?=
 =?utf-8?B?Sy9xcSsyeTZtWDFtNjZ4ZGt2TUV0QUVSbjFseGtCVXArWHRsZGJoNmxNNjQ2?=
 =?utf-8?B?QTNpeFRURnhYVHZFcU95cjE2YW5hdy9WSGlSVHZXd05wZXc1MGpybkIrbVMv?=
 =?utf-8?B?ZCtITHp0dkhGZU1FdU9Bb0owZHpZb2VyTWpyS1Rrb0EvdDAzZFJtWkU5N3Rv?=
 =?utf-8?B?bUY5Z2xMdWZEd0QvckpoRk9QdHpadkYxMVpxRElNOEozYVRjNWRweE5YekR2?=
 =?utf-8?B?aWFnT3dEdXMxc05CdStkU3lHWDNlOExlSkZSK2lvWlRHcUl2MUpSNmcwZStN?=
 =?utf-8?B?U2RRMXZkZHl5WlNYeS9tekhsYk0rY1ZISHh4R2VSS3lSM0NZZk52Zm9EL1I0?=
 =?utf-8?B?UHNwQVNLNCtGNXpvM04wL1hyQWFHQkJ0aWg1Z05HcnM3K2dIaWprMWhjTDlz?=
 =?utf-8?B?VnNTdWNOODVqSndTMitCK3h5MHh2dm5rM3hqMmEwTGxKczAveklkYVYxZjVl?=
 =?utf-8?B?a0piQ0dNSndTckNSUVNFSVFwSzNvZHdzNUJFTkFRYk1KYUFLS3VDaTZGNk1y?=
 =?utf-8?B?bmcxUDcwakJnNEhwQVhtNzVaZzhHR2gxVjNxSElZaURRUTZQbUV0M0N3SEl5?=
 =?utf-8?B?NXNoNE14clhxakJEU3FOVXZXRWNDN1pWQm5oSTFMODJ0TWswL2xzbDRHbFVy?=
 =?utf-8?B?SkMyVVF3Q0daY1o3dGxVaU1RQmp4WjIrZmF2eE03TkFBMERZQSszYjhlU1NX?=
 =?utf-8?B?blVoUGlXUDd4OTk0cW1hb0ZyYnZCRlV6TjJqZENMWjVRU0VEMUZGamk5SjhW?=
 =?utf-8?B?K0xZbU45TzNodjdvRXR4SWxPSW5vcFhRNTRFUUFBeGY0dHlOZGFHdVNnSEJj?=
 =?utf-8?B?Vzg2MFpwZmY1cUtORGJ2bXRsSlgvSkVIUUN1cjA5d1QxMGxxc1VzRzdCT0pL?=
 =?utf-8?B?Z2ZMK0QyNDVTeDQ4VDZFK0JaZXpRZDFYRkxmdXRGQWN2ajZpQjYvakRSVXRT?=
 =?utf-8?B?OWphelpxd1ppMTZKbDdtZW1iRXNzNVM1dDJCVDd5aEdtSFdmSThnZThKaCtQ?=
 =?utf-8?B?WFRLdSswYzlDUmdrd3ZJMmt0NDZ1U0NhT09lQjcvRWdwMUZBYVllcDhLWTBS?=
 =?utf-8?B?c3Z2VURSbkc4NnZ5TnZQUEQxbXhweEZ5dlBrUSt6ZjE4U3dSZERrbC91a3dF?=
 =?utf-8?B?eVhlUWNOTjBZei9uUnk1N29HTWtPcDh5TDlVa3RCZ2FYN0x3cXAySGhtNDJK?=
 =?utf-8?B?eUZ6UEUxbU5Iczl5UVpmQXQzM1RlUGhkaFZhZk5oR2thdnh1RHMxT0VzQ0xD?=
 =?utf-8?B?UnhEUkZqZUNtQXBjbVNsYUY1Mm10Rm9tc0lhS2ljZFlhSERmM3ozTit0c3ZW?=
 =?utf-8?B?dHNqQk94eHpXQi9NV29WZ1NrKzlTUHNhbVIza2FSaXJsRGtjQWFmN1NxMS8z?=
 =?utf-8?B?SzUwY1B6VUwrUFA2ZzlPb1prUE9la3Z6UUwybmlleGVvTTJZUThlK0dFSVRp?=
 =?utf-8?B?bWJnS1RTYlZHeDdUQS95czVkMXQwNUVsRUVscnBKYlZEYk1xZUZWMTFjd3hR?=
 =?utf-8?B?RFYybGdHbWFMajl2V3MrUUVBeTR5SStScGdOVXFxcURIWGFKc3pRZE13bGQw?=
 =?utf-8?B?Z2c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd939ef-5963-4f83-e7c2-08dcddbbb442
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 23:42:23.5304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NjnRAkfWx37SGXv1l6QTxzcEwzxxfHsPtIGtg4c3B5D3jvHkxdoRQJ/UysTzdhxOM7fvGt3zCXOpM+vvKVQNrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6799

--------------MIFCgvRqhTe8CcUZx9fSnSbY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Daniel,

On 25/09/2024 23:57, Daniel Verkamp wrote:
> On Wed, Sep 25, 2024 at 8:05 AM Max Gurtovoy<mgurtovoy@nvidia.com> wrote:
>> This field is only valid when the VIRTIO_BLK_F_BLK_SIZE feature bit is
>> set.
>>
>> The blk_size field represents the smallest addressable unit of data that
>> can be read from or written to the device. It is always a power of two
>> and typically ranges from 512 bytes to larger values such as 4 KB.
> I agree that this is what the blk_size field probably *should* have
> meant (matching other storage protocols like ATA, SCSI, NVMe, ...),
> but I believe rewriting the spec like this changes the meaning of the
> blk_size field in an incompatible way.

I believe that this is more of a clarification than a re-write.

>
> Previously, blk_size was described as the "optimal" sector size, so it
> seems clear that the driver is still allowed to send requests that are
> not aligned to blk_size ("awareness of the correct value can affect
> performance" but no mention of correctness). A device may need to do
> extra work to support this, of course, such as turning an unaligned
> write into a read-modify-write sequence if the underlying storage
> device doesn't support such an access directly, but such requests are
> still valid. It's also perfectly fine for a driver to ignore
> device-offered features like VIRTIO_BLK_F_BLK_SIZE and still operate
> correctly.

A device should report its block size (logical) using the 
VIRTIO_BLK_F_BLK_SIZE feature. For legacy devices that don't report this 
feature, Linux assumes a 512-byte block size.

Drivers should not ignore this feature when it's offered by the device. 
It's crucial for correct operation IMO.

The statement "driver is still allowed to send requests that are not 
aligned to blk_size" needs explicit clarification in the spec.

 From my understanding of the spec, the driver is not allowed to do so 
(otherwise error will be returned or the behavior is undefined).

In Linux, the reported blk_size is used to set logical_block_size, while 
physical_block_exp is used to calculate the physical_block_size.

Regarding the specification statement: "This does not affect the units 
used in the protocol (always 512 bytes)":

This likely refers to how certain fields in the virtio-blk protocol are 
expressed, not the actual logical block size used for I/O operations. 
For example: capacity reporting, max_discard_sectors and Other fields 
that are expressed in 512 byte units.

>> Linux/Windows systems typically use 512-byte/4-KB block sizes.
> While probably true, this doesn't really have anything to do with the
> change (and the logical block size is a property of the storage medium
> and controller, not anything to do with the operating system).

Please ignore it. I'll remove this from v2.

>
>> This description provides clarity on the constraints of the blk_size
>> field.
>>
>> Signed-off-by: Max Gurtovoy<mgurtovoy@nvidia.com>
>> ---
>>   device-types/blk/description.tex | 20 ++++++++++++++++++--
>>   1 file changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
>> index 2712ada..88a7591 100644
>> --- a/device-types/blk/description.tex
>> +++ b/device-types/blk/description.tex
>> @@ -3,7 +3,10 @@ \section{Block Device}\label{sec:Device Types / Block Device}
>>   The virtio block device is a simple virtual block device (ie.
>>   disk). Read and write requests (and other exotic requests) are
>>   placed in one of its queues, and serviced (probably out of order) by the
>> -device except where noted.
>> +device except where noted. Each block device consists of a sequence of logical
>> +blocks. A logical block represents the smallest addressable unit of data that
>> +can be read from or written to the device. The logical block size is always a
>> +power of two. Logical block sizes may be 512 bytes, 1KB, 2KB, 4KB, 8KB, etc.
> Does this imply that a device may return an error for a request where
> the sector or num_sectors fields are not aligned to the blk_size? If
> so, it should be called out as a more explicit normative requirement,
> but that would definitely be an incompatible change.

As mentioned, the logical block size, such as 512 bytes, defines the 
smallest addressable unit for I/O operations on the storage device.
This has important implications for I/O requests:
1. Minimum I/O size: You cannot send I/O requests smaller than the 
logical block size. For example, with a 512-byte logical block size, 
requests of 128 bytes are not valid.
2. I/O alignment: All I/O requests must be aligned to the logical block 
size. This means the target start address (on the media device) of the 
I/O must be a multiple of the logical block size (the expressed units in 
the spec are not relevant).
3. I/O size granularity: The size of I/O requests must be a multiple of 
the logical block size. For a 512-byte logical block size, valid I/O 
sizes would be 512 bytes, 1024 bytes, 1536 bytes, and so on.

>
> The "smallest addressable unit" wording is also more confusing than
> clarifying here, since in virtio-blk, the "smallest addressable unit"
> is always 512 bytes, regardless of blk_size (even if a change like
> this would enforce limits on the sector values that would actually be
> allowed, it would still be possible to create a request that refers to
> a smaller unit than blk_size, unlike other storage protocols where
> logical block size changes the multiplier of the address, making it
> impossible to address smaller units).

Can you please point me to the place in spec that explicitly say that 
"in virtio-blk, the smallest addressable unit is always 512 bytes, 
regardless of blk_size" ?

I didn't find it in the spec and I don't agree with this call if it is 
implicit.

The implementation of the Linux kernel driver isn't implemented in this 
manner as well.

>
>>   \subsection{Device ID}\label{sec:Device Types / Block Device / Device ID}
>>     2
>> @@ -135,6 +138,9 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
>>   present. The availability of the others all depend on various feature
>>   bits as indicated above.
>>
>> +The field \field{blk_size} exists only if VIRTIO_BLK_F_BLK_SIZE is set. This field
>> +reports the logical block size of the device, expressed in bytes.
> Not a new problem with this change (see another example right below),
> but "set" is unclear - does that mean it is present if the device
> offered the feature, or only if the driver also accepted it?

I just followed the spec wording.

I meant to say "The field \field{blk_size} exists only if 
VIRTIO_BLK_F_BLK_SIZE is offered by the device.

I can change it in v2.

>
>>   The field \field{num_queues} only exists if VIRTIO_BLK_F_MQ is set. This field specifies
>>   the number of queues.
>>
>> @@ -228,7 +234,7 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>>   \item The device size can be read from \field{capacity}.
>>
>>   \item If the VIRTIO_BLK_F_BLK_SIZE feature is negotiated,
>> -  \field{blk_size} can be read to determine the optimal sector size
>> +  \field{blk_size} can be read to determine the logical block size
>>     for the driver to use. This does not affect the units used in
>>     the protocol (always 512 bytes), but awareness of the correct
>>     value can affect performance.
>> @@ -282,6 +288,12 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>>
>>   \drivernormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
>>
>> +Drivers MUST negotiate VIRTIO_BLK_F_BLK_SIZE if the feature is offered by the
>> +device.
> Why is this a MUST? This is also an incompatible change since there
> was no such requirement before, and drivers are free to ignore
> features they don't care about.

I can say SHOULD, but then the driver that is ignoring this feature may 
guess/assume the logical block size and it can be wrong.

This may lead to an undefined behavior.

We do it for legacy devices that don't offer this feature, because this 
is the best we can do.

>
>> +If the VIRTIO_BLK_F_BLK_SIZE feature is not offered by the device, then drivers
>> +MAY assume that the logical block size is 512 bytes.
>> +
>>   Drivers SHOULD NOT negotiate VIRTIO_BLK_F_FLUSH if they are incapable of
>>   sending VIRTIO_BLK_T_FLUSH commands.
>>
> [...]
>
> In my opinion, this change should probably be something more like a
> non-normative comment, along the lines of "blk_size is often the
> logical block size of the storage medium", without changing the
> existing meaning from previous spec versions. If there is a desire to
> introduce a hard requirement for logical-block-aligned I/O requests,
> that seems like it would have to be a new field and/or feature bit.

I believe we can use the existing VIRTIO_BLK_F_BLK_SIZE feature.

This patch makes the relationship between blk_size field and the 
smallest addressable unit (logical block) for READ/WRITE operations clear.

>
> Thanks,
> -- Daniel
--------------MIFCgvRqhTe8CcUZx9fSnSbY
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hi Daniel,<br>
    </p>
    <div class="moz-cite-prefix">On 25/09/2024 23:57, Daniel Verkamp
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CABVzXAntBt+5L4a1ntud_7j_EHiB4yG6FuskNaPBirOfLJ7i6w@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">On Wed, Sep 25, 2024 at 8:05 AM Max Gurtovoy <a class="moz-txt-link-rfc2396E" href="mailto:mgurtovoy@nvidia.com">&lt;mgurtovoy@nvidia.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
This field is only valid when the VIRTIO_BLK_F_BLK_SIZE feature bit is
set.

The blk_size field represents the smallest addressable unit of data that
can be read from or written to the device. It is always a power of two
and typically ranges from 512 bytes to larger values such as 4 KB.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I agree that this is what the blk_size field probably *should* have
meant (matching other storage protocols like ATA, SCSI, NVMe, ...),
but I believe rewriting the spec like this changes the meaning of the
blk_size field in an incompatible way.</pre>
    </blockquote>
    <p>I believe that this is more of a clarification than a re-write.<br>
    </p>
    <blockquote type="cite" cite="mid:CABVzXAntBt+5L4a1ntud_7j_EHiB4yG6FuskNaPBirOfLJ7i6w@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">

Previously, blk_size was described as the &quot;optimal&quot; sector size, so it
seems clear that the driver is still allowed to send requests that are
not aligned to blk_size (&quot;awareness of the correct value can affect
performance&quot; but no mention of correctness). A device may need to do
extra work to support this, of course, such as turning an unaligned
write into a read-modify-write sequence if the underlying storage
device doesn't support such an access directly, but such requests are
still valid. It's also perfectly fine for a driver to ignore
device-offered features like VIRTIO_BLK_F_BLK_SIZE and still operate
correctly.
</pre>
    </blockquote>
    <p><span class="fontstyle0">A device should report its block size
        (logical) using the VIRTIO_BLK_F_BLK_SIZE feature. For legacy
        devices that don't report this feature, Linux assumes a 512-byte
        block size.<br>
      </span></p>
    <p><span class="fontstyle0">Drivers should not ignore this feature
        when it's offered by the device. It's crucial for correct
        operation IMO.</span></p>
    <p><span class="fontstyle0">The statement &quot;driver is still allowed
        to send requests that are not aligned to blk_size&quot; needs
        explicit clarification in the spec.</span></p>
    <p><span class="fontstyle0">From my understanding of the spec, the
        driver is not allowed to do so (otherwise error will be returned
        or the behavior is undefined).<br>
      </span></p>
    <p></p>
    <p>In Linux, the reported blk_size is used to set
      logical_block_size, while <span class="fontstyle0">physical_block_exp
        is used to calculate the physical_block_size.</span></p>
    <p>Regarding the specification statement: &quot;This does not affect the
      units used in the protocol (always 512 bytes)&quot;:</p>
    This likely refers to how certain fields in the virtio-blk protocol
    are expressed, not the actual logical block size used for I/O
    operations. For example: capacity reporting, max_discard_sectors and
    Other fields that are expressed in 512 byte units. <br>
    <p> </p>
    <blockquote type="cite" cite="mid:CABVzXAntBt+5L4a1ntud_7j_EHiB4yG6FuskNaPBirOfLJ7i6w@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Linux/Windows systems typically use 512-byte/4-KB block sizes.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
While probably true, this doesn't really have anything to do with the
change (and the logical block size is a property of the storage medium
and controller, not anything to do with the operating system).</pre>
    </blockquote>
    <p>Please ignore it. I'll remove this from v2.<br>
    </p>
    <blockquote type="cite" cite="mid:CABVzXAntBt+5L4a1ntud_7j_EHiB4yG6FuskNaPBirOfLJ7i6w@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">This description provides clarity on the constraints of the blk_size
field.

Signed-off-by: Max Gurtovoy <a class="moz-txt-link-rfc2396E" href="mailto:mgurtovoy@nvidia.com">&lt;mgurtovoy@nvidia.com&gt;</a>
---
 device-types/blk/description.tex | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
index 2712ada..88a7591 100644
--- a/device-types/blk/description.tex
+++ b/device-types/blk/description.tex
@@ -3,7 +3,10 @@ \section{Block Device}\label{sec:Device Types / Block Device}
 The virtio block device is a simple virtual block device (ie.
 disk). Read and write requests (and other exotic requests) are
 placed in one of its queues, and serviced (probably out of order) by the
-device except where noted.
+device except where noted. Each block device consists of a sequence of logical
+blocks. A logical block represents the smallest addressable unit of data that
+can be read from or written to the device. The logical block size is always a
+power of two. Logical block sizes may be 512 bytes, 1KB, 2KB, 4KB, 8KB, etc.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Does this imply that a device may return an error for a request where
the sector or num_sectors fields are not aligned to the blk_size? If
so, it should be called out as a more explicit normative requirement,
but that would definitely be an incompatible change.</pre>
    </blockquote>
    <p>As mentioned, the logical block size, such as 512 bytes, defines
      the smallest addressable unit for I/O operations on the storage
      device.<br>
      This has important implications for I/O requests:<br>
      1. Minimum I/O size: You cannot send I/O requests smaller than the
      logical block size. For example, with a 512-byte logical block
      size, requests of 128 bytes are not valid.<br>
      2. I/O alignment: All I/O requests must be aligned to the logical
      block size. This means the target start address (on the media
      device) of the I/O must be a multiple of the logical block size
      (the expressed units in the spec are not relevant).<br>
      3. I/O size granularity: The size of I/O requests must be a
      multiple of the logical block size. For a 512-byte logical block
      size, valid I/O sizes would be 512 bytes, 1024 bytes, 1536 bytes,
      and so on.<br>
    </p>
    <blockquote type="cite" cite="mid:CABVzXAntBt+5L4a1ntud_7j_EHiB4yG6FuskNaPBirOfLJ7i6w@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">

The &quot;smallest addressable unit&quot; wording is also more confusing than
clarifying here, since in virtio-blk, the &quot;smallest addressable unit&quot;
is always 512 bytes, regardless of blk_size (even if a change like
this would enforce limits on the sector values that would actually be
allowed, it would still be possible to create a request that refers to
a smaller unit than blk_size, unlike other storage protocols where
logical block size changes the multiplier of the address, making it
impossible to address smaller units).</pre>
    </blockquote>
    <p>Can you please point me to the place in spec that explicitly say
      that &quot;<span style="white-space: pre-wrap">in virtio-blk, the smallest addressable unit </span><span style="white-space: pre-wrap">is always 512 bytes, regardless of blk_size&quot; ?</span></p>
    <p>I didn't find it in the spec and I don't agree with this call if
      it is implicit.</p>
    <p>The implementation of the Linux kernel driver isn't implemented
      in this manner as well.<br>
    </p>
    <blockquote type="cite" cite="mid:CABVzXAntBt+5L4a1ntud_7j_EHiB4yG6FuskNaPBirOfLJ7i6w@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> \subsection{Device ID}\label{sec:Device Types / Block Device / Device ID}
   2
@@ -135,6 +138,9 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
 present. The availability of the others all depend on various feature
 bits as indicated above.

+The field \field{blk_size} exists only if VIRTIO_BLK_F_BLK_SIZE is set. This field
+reports the logical block size of the device, expressed in bytes.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Not a new problem with this change (see another example right below),
but &quot;set&quot; is unclear - does that mean it is present if the device
offered the feature, or only if the driver also accepted it?</pre>
    </blockquote>
    <p>I just followed the spec wording.</p>
    <p>I meant to say &quot;<span style="white-space: pre-wrap">The field \field{blk_size} exists only if VIRTIO_BLK_F_BLK_SIZE is offered by the device.</span></p>
    <p>I can change it in v2.<br>
    </p>
    <blockquote type="cite" cite="mid:CABVzXAntBt+5L4a1ntud_7j_EHiB4yG6FuskNaPBirOfLJ7i6w@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> The field \field{num_queues} only exists if VIRTIO_BLK_F_MQ is set. This field specifies
 the number of queues.

@@ -228,7 +234,7 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
 \item The device size can be read from \field{capacity}.

 \item If the VIRTIO_BLK_F_BLK_SIZE feature is negotiated,
-  \field{blk_size} can be read to determine the optimal sector size
+  \field{blk_size} can be read to determine the logical block size
   for the driver to use. This does not affect the units used in
   the protocol (always 512 bytes), but awareness of the correct
   value can affect performance.
@@ -282,6 +288,12 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic

 \drivernormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}

+Drivers MUST negotiate VIRTIO_BLK_F_BLK_SIZE if the feature is offered by the
+device.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Why is this a MUST? This is also an incompatible change since there
was no such requirement before, and drivers are free to ignore
features they don't care about.</pre>
    </blockquote>
    <p>I can say SHOULD, but then the driver that is ignoring this
      feature may guess/assume the logical block size and it can be
      wrong.</p>
    <p>This may lead to an undefined behavior.</p>
    <p>We do it for legacy devices that don't offer this feature,
      because this is the best we can do.<br>
    </p>
    <blockquote type="cite" cite="mid:CABVzXAntBt+5L4a1ntud_7j_EHiB4yG6FuskNaPBirOfLJ7i6w@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+If the VIRTIO_BLK_F_BLK_SIZE feature is not offered by the device, then drivers
+MAY assume that the logical block size is 512 bytes.
+
 Drivers SHOULD NOT negotiate VIRTIO_BLK_F_FLUSH if they are incapable of
 sending VIRTIO_BLK_T_FLUSH commands.

</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">[...]

In my opinion, this change should probably be something more like a
non-normative comment, along the lines of &quot;blk_size is often the
logical block size of the storage medium&quot;, without changing the
existing meaning from previous spec versions. If there is a desire to
introduce a hard requirement for logical-block-aligned I/O requests,
that seems like it would have to be a new field and/or feature bit.</pre>
    </blockquote>
    <p>I believe we can use the existing <span class="fontstyle0">VIRTIO_BLK_F_BLK_SIZE</span>
      feature.<br>
    </p>
    <p>This patch makes the relationship between blk_size field and the
      smallest addressable unit (logical block) for READ/WRITE
      operations clear.<br>
    </p>
    <blockquote type="cite" cite="mid:CABVzXAntBt+5L4a1ntud_7j_EHiB4yG6FuskNaPBirOfLJ7i6w@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">

Thanks,
-- Daniel
</pre>
    </blockquote>
  </body>
</html>

--------------MIFCgvRqhTe8CcUZx9fSnSbY--
