Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011019.outbound.protection.outlook.com [52.101.57.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C2B24A069
	for <virtio-dev@lists.linux.dev>; Thu, 15 Oct 2026 12:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792065674; cv=fail; b=Cwx4sPm6kH7EMawoj3X4m72pFYR1JoIEerF73Jlo/AAxpTVsT75tz3cuysmSd1DI7MnTHFsO5iqWn5BOVUWscpQbjFm8P4YPGtiS8Vg9CdPb18sZssWgs8zGY+5lZYdXEYVSpZt73er4kebvTUOEFGw3As7/pt6zo0+KpxoCv8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792065674; c=relaxed/simple;
	bh=V0hQbEZy1B54EYE6qUkg+d4ZkIJrA0uQxwqmnBTa0XQ=;
	h=Content-Type:Message-ID:Date:Subject:To:Cc:References:From:
	 In-Reply-To:MIME-Version; b=kx+PAEiuqleGDg4v0qiE+hBp5he8qYzTNubVgKQ25rVdo97dWGSOQm7sxNdWosE/qM1gNedkojsV8RPv3OyMMNIrQ+rkBiHkrfup9CyaGgLc1k/QeEGueYsB4MG5LwckB6dwYs11wO9kuXKT7EjSXmiiGq2Vqfm8r+bE2kECkt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H51yfcAw; arc=fail smtp.client-ip=52.101.57.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H51yfcAw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4aR92Q10OkRccqTOhMIOR8zyCW6qxTM4SDBHBUQVjkqIqZGK/5zxdjBNuplucjZ9XQ2wT/gLfOfLCXzMs4pmZ/EWQTgwH39GP1IQ4WzVziTVe1JCMBNkbarxmhfrDySGKovWBvPN0fUyX3sMm/KCEsKQqfBKvuTxMODV6lnfMHDoAScS8ilv893QlDuXJXJ2vN3Rdp6pgt2Hs3Hgp0V+ho72DSW33leyhBN7b+qlInrLB/mnuEZx/oUU7rAfTBMZVz2UhqrbWdWHS2TXjJk9JXdtCM78j+bw315gormjsa5PZN2Nt5esF+qR7EU6dzW7/VVzrpN5cv00RQc3ywdlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80fcik6+BZ40XgEewk+EsYsBzeos60fG06UofydrWwY=;
 b=tRuZFrFchxcWIBpWgeZ47bzLMdm/kgLjobs9VRZibvJ44XoQjVb/gAwSm55WfxcHRSe3v1vHptRdEb0HIp0bgJKEsHQ3y6pk23o1hmMt9xgH300NXN/mTjMVs7giHx3fPHnwCBGEsmuQxdFvPbMXWGNmDsal15jkgrwzP3wLUdba5OB2u3H9x7NgZijQUqt0ESFJNZeKqqhKh3RqR5g64DBVJey091C1MXlMwa5+8cLz3H+PMQHTM85mKcqskchamlWmGUVu5Gd9ZPug3/K4HtSfnN8ZzOYz+lfGrj435k0xFB7IallYF2u9bemCVhhjDsPP7tnAE1moJXf+j0saxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80fcik6+BZ40XgEewk+EsYsBzeos60fG06UofydrWwY=;
 b=H51yfcAw3vTd4xITzobpG+dNqqfewO9wzVyCKRNGRqXOdTPRvOAyoA3EUo2GdPp2YiWprEvk6hu0w6hasm1f+qwTvYCnDGczrZuq6zoTM4+H7jj4HGV1Kvmkh3Ybc/o1BDm5vTDRIV45qAw/ETeYW3ld0NYP81jDIlDEQAp8me9hZ7fCyH20LU5K2N+BtZot+2hGNgQLURBULaeX7OhOCCPR+tFpegZQgWEBtCyvrdtyhOOe1Qn1bwOgaya0qS6PaOS2gE36lFAcJ3uKdNxROTub5xGQG2/mg6Q4AV2hPJDWKPodRjhEhnSglBpedjyw+FwgLLkGX2+xM4Cd976qpQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7558.namprd12.prod.outlook.com (2603:10b6:8:133::21)
 by CH8PR12MB410303.namprd12.prod.outlook.com (2603:10b6:610:32e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 12:01:07 +0000
Received: from DS0PR12MB7558.namprd12.prod.outlook.com
 ([fe80::96ea:b67a:4a5b:85e0]) by DS0PR12MB7558.namprd12.prod.outlook.com
 ([fe80::96ea:b67a:4a5b:85e0%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 12:01:07 +0000
Content-Type: multipart/alternative;
 boundary="------------YqREdxC6iTFcvhNs1DaX1RbX"
Message-ID: <0b6fa40c-5a79-4047-9c20-d5c83dc7ee6c@nvidia.com>
Date: Thu, 15 Oct 2026 15:01:04 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] virtio-blk: Add inline encryption support
To: Linlin Zhang <linlin.zhang@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.linux.dev,
 ebiggers@kernel.org, neeraj.soni@oss.qualcomm.com, parav@nvidia.com
References: <20260913161628.368484-1-linlin.zhang@oss.qualcomm.com>
 <20260917210841.GD331587@fedora>
 <2f9affb3-0d1b-4469-9a66-ba052d2d1b6a@oss.qualcomm.com>
 <20260922131442.GB18339@fedora>
 <3a933df3-dff7-4ef3-a120-4c6e22c1fcc1@oss.qualcomm.com>
 <de535820-591b-40f2-b840-d987c3253765@nvidia.com>
 <9515779b-a6da-407f-99f2-011e51683d15@oss.qualcomm.com>
 <20261008060644-mutt-send-email-mst@kernel.org>
 <d503aee0-9920-4c0b-b9a0-c08e505cc3ea@nvidia.com>
 <426abc9a-c7b4-4631-a5fe-3b2bba1d0414@oss.qualcomm.com>
 <4ed90e46-0dc9-40ba-b8a9-800d40b34ef9@nvidia.com>
 <01f3caa9-a1c3-4511-a104-7179ce1791f8@oss.qualcomm.com>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <01f3caa9-a1c3-4511-a104-7179ce1791f8@oss.qualcomm.com>
X-ClientProxiedBy: TL0P290CA0014.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::8)
 To DS0PR12MB7558.namprd12.prod.outlook.com (2603:10b6:8:133::21)
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7558:EE_|CH8PR12MB410303:EE_
X-MS-Office365-Filtering-Correlation-Id: 2832bf97-f147-4638-8715-08df2ab3feaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|6133799003|18002099003|22082099003|10067099003|13003099007|3023799007|8096899003|4143699003|261009223027099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	kITVHyh3Z0RAEf0VXywcaMFhHVl+mjNbHB7DEZYHjV4abyQVbQvV5ljQa34QvWO3wSZNGvpXfVKusST50RmDOEFkwHlWSe+ehKdAI7spqOaSU/V2xfYzCKhpOVmvw6kTa/aTIOU/UwbzbbkNt2szNDwgxMhVBP2KzXJEz9fcCH33loleoypAWQQOurK2mhCyWr6LSdf1CMk5VYSCtTlUb7PCM9NcV8I7fEGcY8PE5dah9eNbzkIWfmLipxXtCzv7IOTqL5br8fkeQnxRNhDfrJ+blZplmNqWoVQeP6Ib2rSOkaUeI9yMRofqLEyjV99KUfyD0UuFkoj+mo+oEm2z7wWJ/omzX1+ZDCrx51lU/Z3oISnluj2+6wCNCqPTXbSPgAgRnQupwYKDGE0DCwkDyEtjRvNimQmjci1eRG10WUIa0kpzKwRv/cP00BMvXLeXz73Cfq/4kSRXyA7wzPSa/IhZ8fNd65Uuamw9cyoYr0wCHtl2Jzp6M63+aCUgZJ1pPIcbu7gD3OE2vL2O1d+X58QHi6bAgtyraqKuQ4eU1CNebbM38yu6Y68+8+YYyOgUdaLSca+RuVlvl5+kZfWwCPrHvOHJp+7uTxMO49V192iOiSAGGd33LQJ4mIYTgQ8lTx3zhmiQ2uadPyvkHMDjFKQnF6jpMtkxVoYG7nqCNnI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7558.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(18002099003)(22082099003)(10067099003)(13003099007)(3023799007)(8096899003)(4143699003)(261009223027099003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFRIeTFaNmtORG1SbVVEdzdNczlUMjFFWjVXeloxWmtwb0ZTUktuazVaZEhh?=
 =?utf-8?B?S1RlaXNUWG5rVldkbmdMcVFlN0JVMHo2OVpKRnBhMmtOY3VkZ1BpZVRyUDRJ?=
 =?utf-8?B?ZXArMW1VVGdGVHJZanhHaFZGSkFXVU1SV29RK2ZVcjhmMlI4YW5HZnl4VzY1?=
 =?utf-8?B?Z0RCeGdvUTZnNlZ3SjF3YzJVWFFEMSswRE1WVzJPRC94Z1RPNkpJbkE0ZHM3?=
 =?utf-8?B?eWN6c2ZSRmF2VTAvSmFiNWkzUUJlNEZ3d1RZVkxyY3J4SEp3eUVGeFpTMVU3?=
 =?utf-8?B?eWFTSUd5M0JpQTRIcEI1OWtzbjVTUWdFdnZBc1dUYmVVY2dGN0UvZEtXZDZj?=
 =?utf-8?B?U0Z5akI1V1B3eFVCdUNmY1YzaFRrek9mZkdqN3V5MG0reHQ2eEFHTG9MNTFJ?=
 =?utf-8?B?M0Q2UWhNNnJVYzl6OFRNcW9Xa3pDSFJlTzB3MHlvMHJYamZUb0EzdW5Gblo3?=
 =?utf-8?B?eVpaQjQwVE1DZ0xPVUt0N2IxUnltdlJMWWdEalJBNnNGaVVSNzdkRGlMK3g0?=
 =?utf-8?B?NVEwNXNwYUQ3TkFhRHA0citQUDRGYVZsZHIzZHBVYjZlVXRaZEl5ZFI0bjNy?=
 =?utf-8?B?VVBiSUxCWXAzYTM4VHZpTERKRVpZNFB3dEVIZElxV2QvZXV6Q0w3TUsyTUFG?=
 =?utf-8?B?OEIxeWs4b1YzOGhMTWRlZjhDZG5nVi92bGlUZXJtZjkvNHdjZWNyalpNQ3Zw?=
 =?utf-8?B?Vys2RldVRnFDejNMbnZTT1ZEekVQZ1BSQ0FoeTFpNDVDWUlDMkcrQ2xlTnNp?=
 =?utf-8?B?TTVwaGdkOUpkaFluam9hN1A1S3RDeHlEQzMxdnU2clk3aWIwblJhT0VuRzNr?=
 =?utf-8?B?d3dFMEl3V1h6OHpQYkRUck1TdjVyTEtuZTBkbFEvUG1GdEdXcjRlKzdxVTA2?=
 =?utf-8?B?cWpvZzgxV285YXNIQyt4K2FWYzdPbU9xVHc0bzh5bGVLU2pRVU5UazJBQ3g1?=
 =?utf-8?B?OURmYXRqcmN1Y0hSaWo2cVJwQnlOMkR6cGZDTVFmQkdmUHlXM0RxWHpNVzJj?=
 =?utf-8?B?RmNDc0N0a0ZXNWRXUUh3TjJibEVKWG13UldJeGRDb0NwMWJmNEZ0SnNVRkxs?=
 =?utf-8?B?QVJmNU12WnZNaHBsWUYvVzdoZFNyblQya29tVEZRT0lMZDBTZWhXbXFmRnJS?=
 =?utf-8?B?dVhGak1yV2RQblZjZGo2YkhIK0d6bW5RcUFJYUVpbFF1RVBQVzlTSTlwMWtl?=
 =?utf-8?B?M1JFWDRiOWhLNnVGcElwSjZPeU1JRUt2T2s1N1NhL3huTmNaRldkMzhqb29L?=
 =?utf-8?B?c254V3FuMnJRRVpMSG9lLzc1amhsdzN0ekpwaTdNMHQ1cnpON0Focmc2Q09Q?=
 =?utf-8?B?VDYzdjFORFdkejBaMExqKzFWOUx4dWhLOXppYW9YaTREeEt6WTA3Q0xDZFIr?=
 =?utf-8?B?NzBacFlHRDIvQWVCMTRaeThsZXFNOFVSYWQydXN3UnNnN0lRQkFtY202V1Uv?=
 =?utf-8?B?MWtnRGhXZ3VGYSt4bWJqcnA0WUVLcmpmb0wzQUZ0YlJMa0Y3YnB4ZHNrV0Q4?=
 =?utf-8?B?ZHYvcUtHTk95OUt0QU9QZS9JSTBadmx0WFgxVGJjWGVNdUYyMHhFODJmUVd1?=
 =?utf-8?B?RG9lRm10RCt0b2U1aGdYVXBkdklZdWowV3lySUMrL2xvNHlDNStRcFJvb1Z5?=
 =?utf-8?B?SVp4ZWdGcFl3eFl6dlVHT2o5NzBHYmlWL2hzUnFka1NpZ3I0NWRBWFdkTjhI?=
 =?utf-8?B?SWJPSWk3YjAzMkkrK3NsbjBxT3l0dTlHaVBqdU5BeEd2ZERXS0JxMjlib0Ft?=
 =?utf-8?B?LzNGZmxQdnhzSzhRS0x6alo4SUVCWW5pd3dhYW9SdE1OdThPMUpaYXhrNDBO?=
 =?utf-8?B?cGxDaUVJYy9EdmhJeUNEU3owUEM2WmxNZG5VUTNlTXdnbjVXT1AwNFI1QUg1?=
 =?utf-8?B?QzI1aVlmTlVITUVaZnpNZFA2cnVlam4yK2RWSDlaakN5VGcydGw5YmVDMXdC?=
 =?utf-8?B?bG1RK04xaDAxenVmOGxFMmgvRDcweFpuY1ZjajlrSEdJQU5OZVBFMVlGU1Mz?=
 =?utf-8?B?a0VlMVpnOWROMTgvSTFTMm9Tdkl0aEdvOVhPNzdKeTA4Qm1ZV01sOEF3NzJU?=
 =?utf-8?B?RDdXMWxvaUFBQzdrK1l4YlVaYkhLSm9jVlYybktNaEEyQStpU2pUWHlkb1VC?=
 =?utf-8?B?ZDR0T1g5eHBaTUZkM0ZTSlJjaHhFVUswQ2IxTEVaWk1uMGpzMVNDY3FhdjdD?=
 =?utf-8?B?WGNDVUtmS0NSUG1GazI3aHIwa3VoSHViL1BLQ1ErT1lGaW1sTnAxa2JTZjNh?=
 =?utf-8?B?Q2RLeEU2RnRzV1BnbWdkR2Rtb1lJSkkvYy83VmYyRnhGNEt1QkRXWjMyd2ZD?=
 =?utf-8?B?Wm5QTGMzYzJYVFJjRUdyM2ZrakFTcjRGampleDVVUzBxbHNpdm96QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2832bf97-f147-4638-8715-08df2ab3feaa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 12:01:07.3015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nhIOrYNmCaLyT6r12tIwdgm9qjtnmbBjHtb/vRvwM7krFs7WRRUN5cG20goM5ONdJjxR6oocYIZkrpvJazUkXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB410303

--------------YqREdxC6iTFcvhNs1DaX1RbX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 15/10/2026 14:19, Linlin Zhang wrote:
>
> On 10/14/2026 2:07 AM, Max Gurtovoy wrote:
>> On 13/10/2026 19:23, Linlin Zhang wrote:
>>> On 10/13/2026 7:12 AM, Max Gurtovoy wrote:
>>>> On 08/10/2026 13:15, Michael S. Tsirkin wrote:
>>>>> On Thu, Oct 08, 2026 at 05:17:30PM +0800, Linlin Zhang wrote:
>>>>>> On 9/30/2026 6:46 AM, Max Gurtovoy wrote:
>>>>>>> On 24/09/2026 12:35, Linlin Zhang wrote:
>>>>>>>> On 9/22/2026 9:14 PM, Stefan Hajnoczi wrote:
>>>>>>>>> On Tue, Sep 22, 2026 at 12:29:37PM +0800, Linlin Zhang wrote:
>>>>>>>>>> On 9/18/2026 5:08 AM, Stefan Hajnoczi wrote:
>>>>>>>>>>> On Sun, Sep 13, 2026 at 09:16:13AM -0700, Linlin Zhang wrote:
>>>>>>>>>>>> From: linlzhan<linlin.zhang@oss.qualcomm.com>
>>>>>>>>>>>>
>>>>>>>>>>>> This series adds virtio-blk inline encryption support for devices backed
>>>>>>>>>>>> by storage hardware with an inline crypto engine.
>>>>>>>>>>>>
>>>>>>>>>>>> The protocol exposes device capabilities such as keyslot count, maximum
>>>>>>>>>>>> DUN size, and supported key types. Encrypted requests identify a
>>>>>>>>>>>> provisioned keyslot and carry a 256-bit DUN. Key management and crypto
>>>>>>>>>>>> capability discovery use the block device control virtqueue.
>>>>>>>>>>>>
>>>>>>>>>>>> The control virtqueue is defined as a generic framework so that its
>>>>>>>>>>>> buffer layout and queue placement are independent of any particular
>>>>>>>>>>>> control command. Inline encryption then builds on this framework with
>>>>>>>>>>>> explicit crypto command formats, capability validation, and keyslot
>>>>>>>>>>>> state semantics.
>>>>>>>>>>>>
>>>>>>>>>>>> All key related operatios are handled in the control virtqueue, and
>>>>>>>>>>>> the crypto I/O request is handled in the request queue.
>>>>>>>>>>>>
>>>>>>>>>>>> For background on inline encryption in UFS and eMMC storage, see:
>>>>>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/block/inline-encryption.rst
>>>>>>>>>>>>
>>>>>>>>>>>> changes in v3:
>>>>>>>>>>>>      - Add a control virtqueue
>>>>>>>>>>>>      - Move key program/evict/derive_sw_secret/generate/prepare/import to
>>>>>>>>>>>>        the control virtqueue
>>>>>>>>>>> Thank you. This was a big change, especially if you already have an
>>>>>>>>>>> implementation. I appreciate it!
>>>>>>>>>>>
>>>>>>>>>>> My main feedback is that the new control virtqueue commands are not yet
>>>>>>>>>>> documented in enough detail so that implementors could implement them.
>>>>>>>>>>> Once you've decided on the precise semantics, error codes, etc and added
>>>>>>>>>>> them to the spec, then this will round off the inline encryption
>>>>>>>>>>> feature. I look forward to reviewing that in the future.
>>>>>>>>>>>
>>>>>>>>>> Thanks a lot for your comment!
>>>>>>>>>>
>>>>>>>>>> Would you please help clarify what the precise semantics are about? detail
>>>>>>>>>> introduction of the filed in the inline encryption control command struct?
>>>>>>>>>> like struct virtio_blk_crypto_key_desc?
>>>>>>>>> By precise semantics, I mean specifying not just the constants and
>>>>>>>>> structs, but documenting what each command does and how it can fail.
>>>>>>>>> Each of the key slot programming commands needs this. There should be at
>>>>>>>>> least one paragraph for each of VIRTIO_BLK_T_CRYPTO_KEYSLOT_PROGRAM,
>>>>>>>>> VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT, VIRTIO_BLK_T_CRYPTO_DERIVE_SW_SECRET,
>>>>>>>>> VIRTIO_BLK_T_CRYPTO_GENERATE_KEY, VIRTIO_BLK_T_CRYPTO_IMPORT_KEY, or
>>>>>>>>> VIRTIO_BLK_T_CRYPTO_PREPARE_KEY.
>>>>>>>>>
>>>>>>>>> For example:
>>>>>>>>>
>>>>>>>>> The VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT command empties a key slot so that
>>>>>>>>> key information is removed and the key slot cannot be used until it is
>>>>>>>>> programmed again. The key slot index is specified by struct
>>>>>>>>> virtio_blk_crypto_key_desc \field{slot} and all other fields in the
>>>>>>>>> struct are ignored. The command succeeds with VIRTIO_BLK_S_OK if the key
>>>>>>>>> slot index is valid, including if the slot is already empty. If the key
>>>>>>>>> slot index is invalid, the command fails with VIRTIO_BLK_S_IOERR.
>>>>>>>>>
>>>>>>>>> Stefan
>>>>>>>> Thanks for the clear example.
>>>>>>>>
>>>>>>>> I'll follow the same approach and add explicit normative semantics for
>>>>>>>> all inline encryption control requests.
>>>>>>> Can you please explain why we need to introduce yet another VQ type for control?
>>>>>>>
>>>>>>> We've added the Admin VQ as a generic VQ for control operations — I'm not sure why it isn't sufficient.
>>>>>>>
>>>>>>> Adding control VQ to each device type seems strange to me after adding a generic Admin VQ.
>>>>>> Thanks for your comment! And I agree that the Admin VQ should be considered before
>>>>>> adding another device-specific control virtqueue.
>>>>>>
>>>>>> My understanding is that some of the inline encryption commands(get_crypto_modes/program key
>>>>>> /derive_sw_secret/evict key) are runtime operations of a specific virtio-blk deivce.
>>>>>> In particular, different virtio block devices may have different storage hardware sources
>>>>>> of crypto modes, and keyslot programming and eviction are invoked through the block device's
>>>>>> keyslot manager, and the programmed virtual keyslots are subsequently referenced by the
>>>>>> encryption requests submitted on that device's request virtqueues. These commands are
>>>>>> not about the management operation of device group.
>>>>>>
>>>>>> There is also a transport compatibility concern. The current virtio SPEC states that
>>>>>> 'Devices and drivers utilizing Virtio Over MMIO do not support VIRTIO_F_ADMIN_VQ'.
>>>>>> virtio MMIO is extensively used, so using the Admin VQ would make the feature unavailable
>>>>>> for that transport unless the proposal also extended the MMIO transport.
>>>>>>
>>>>>> For these reasons, currently I believe that a virtio-blk control virtqueue is the better
>>>>>> fit: it keeps the complete key lifecycle associated with the block device and remains
>>>>>> usable across the transports required by the feature.
>>>>>>
>>>>>> I would appreciate any feedback or insights from you and Stefan on the V5 patch series
>>>>>> posted for review before October ASAP.
>>>>>>
>>>>> Fundamentally, it does not make sense to force all vqs to be admin VQs.
>>>>>
>>>>> Admin vq would make sense if there is complex resource management going
>>>>> on - like what is happening with all the flow control things in the
>>>>> network device, since they have extensive functionality for managing
>>>>> device resources.
>>>>>
>>>>> Random device specific commands - I am not sure we want that.
>>>>> It remains to be proven.
>>>> Admin vq was added for mgmt/control/admin/non-DATA_IO operations.
>>>>
>>>> Fundamentally, it does not make sense to force random device to create new control VQ since we already defined admin VQs for this purpose.
>>>>
>>>> We could have introduced control VQ on each device type, but we didn't.
>>> Thanks for your comment!
>>>
>>> My concern is that these inline encryption commands are tightly coupled
>>> to a specific virtio-blk device rather than providing generic administrative
>>> functionality.
>> We've all the needed plumbing in place in the AQ for device specific admin commands - see virtio-net specific admin commands.
>>
>>> GET_CRYPTO_MODES exposes capabilities of a particular block device, while
>>> PROGRAM_KEY and EVICT_KEY operate on that device's keyslot manager. The
>>> resulting virtual keyslots are then referenced directly by encryption requests
>>> submitted on the same device's request VQs. The entire key lifecycle therefore
>>> remains local to a single virtio-blk instance and its I/O path.
>>>
>>> My understanding is that Admin VQ was introduced primarily for device agnostic
>>> commands. The GET_CRYPTO_MODES/PROGRAM_KEY/EVICT_KEY control commands appear to
>>> be inherently virtio-blk-specific rather than a cross-device interface.
>>>
>>> There is also a transport consideration: VIRTIO_F_ADMIN_VQ is currently
>>> unavailable for virtio-mmio, while the proposed control VQ approach remains
>>> transport-independent.
>> This limitation was introduced because we didn't want to add more noise when AQ was added (it was already a big change).
>>
>> Nothing really prevents adding AQ to mmio transport.
>>
>>> For these reasons, I currently believe a virtio-blk control VQ is the better
>>> fit.
>>>
>>> I'm appreciated if you can give any feedback about it.
>> I think that the correct path is AQ.
>>
>> Introducing another VQ type for the same purpose (mgmt cmds) seems weird and make device implementation harder.
>>
>> It is much harder to implement a new VQ type than a new opcode in the existing AQ.
>>
> Thanks for your comments!
>
> I agree that reusing the existing AQ avoids introducing another VQ type in virtio-blk.

I'm glad that we're aligned on this one.

>
> My concern is that AQ is currently not supported with virtio-mmio, and adding such
> support appears to be significantly more involved than introducing a
> virtio-blk-specific control VQ.

I don't think that this is a good enough reason for introducing a new VQ 
type in Vblk.

We need the best spec definition, one that will serve us for years to 
come, rather than worrying about 1-2 weeks of additional effort (to a 
task which is completely orthogonal for adding enc to vblk, IMO).

The high level spec enhancements I envision are:

  * Allow ADMIN_VQ on MMIO - Remove VIRTIO_F_ADMIN_VQ from the
    “reserved” MMIO list. Update the feature-bit text to align.
  * Add two read-only registers to the MMIO register table, mirroring
    PCI’s admin_queue_index and admin_queue_num. They are valid only
    when ADMIN_VQ is negotiated. My suggested offsets are 0x0c4 and
    0x0c8, which appear unassigned in my version.
  * Reuse the existing queue flow. PCI’s rule refers to num_queues,
    which MMIO lacks. So either reword it as “admin index is above every
    regular queue index and index plus count stays within 0x10000”, or
    add a NumQueues register.
  * State the Self-group scope - An MMIO owner device supports only
    group type 0x0. Other group types fail with INVALID_GROUP, following
    the existing validation rule.


>
> Given this constraint, Admin VQ support in virtio MMIO will impact the inline
> encryption support on virtio block, so, I prefer to the virtio-blk-specific
> control VQ as this requirement is a more widely and general request, especially
> in the virtualization platform with a Android guest virtual machine.

This is not a constraint worth considering a non-optimal architecture.

Creation of VQs takes device resources. We prefer not introducing new 
VQs if not needed. Adding a new opcode is more reasonable for your 
requirement.

Imagine a block device with N resources for VQs: N-1 for request VQ and 
1 for Admin VQ. If we need to introduce a new CVQ then it will be 
instead of one request VQ resource.

I prefer having a correct architecture.


>>>>> But generally why does this go on a special VQ? Is there a reason?
>>>> Also in other related protocols the key mgmt goes throw a NON-IO Queue..
>>>>
>>>>
>>>>> You define distinct request types seemingly and we are not short on types?
>>>>>
--------------YqREdxC6iTFcvhNs1DaX1RbX
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 15/10/2026 14:19, Linlin Zhang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:01f3caa9-a1c3-4511-a104-7179ce1791f8@oss.qualcomm.com">
      <pre wrap="" class="moz-quote-pre">

On 10/14/2026 2:07 AM, Max Gurtovoy wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
On 13/10/2026 19:23, Linlin Zhang wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">
On 10/13/2026 7:12 AM, Max Gurtovoy wrote:
</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">On 08/10/2026 13:15, Michael S. Tsirkin wrote:
</pre>
            <blockquote type="cite">
              <pre wrap="" class="moz-quote-pre">On Thu, Oct 08, 2026 at 05:17:30PM +0800, Linlin Zhang wrote:
</pre>
              <blockquote type="cite">
                <pre wrap="" class="moz-quote-pre">On 9/30/2026 6:46 AM, Max Gurtovoy wrote:
</pre>
                <blockquote type="cite">
                  <pre wrap="" class="moz-quote-pre">On 24/09/2026 12:35, Linlin Zhang wrote:
</pre>
                  <blockquote type="cite">
                    <pre wrap="" class="moz-quote-pre">On 9/22/2026 9:14 PM, Stefan Hajnoczi wrote:
</pre>
                    <blockquote type="cite">
                      <pre wrap="" class="moz-quote-pre">On Tue, Sep 22, 2026 at 12:29:37PM +0800, Linlin Zhang wrote:
</pre>
                      <blockquote type="cite">
                        <pre wrap="" class="moz-quote-pre">On 9/18/2026 5:08 AM, Stefan Hajnoczi wrote:
</pre>
                        <blockquote type="cite">
                          <pre wrap="" class="moz-quote-pre">On Sun, Sep 13, 2026 at 09:16:13AM -0700, Linlin Zhang wrote:
</pre>
                          <blockquote type="cite">
                            <pre wrap="" class="moz-quote-pre">From: linlzhan <a class="moz-txt-link-rfc2396E" href="mailto:linlin.zhang@oss.qualcomm.com">&lt;linlin.zhang@oss.qualcomm.com&gt;</a>

This series adds virtio-blk inline encryption support for devices backed
by storage hardware with an inline crypto engine.

The protocol exposes device capabilities such as keyslot count, maximum
DUN size, and supported key types. Encrypted requests identify a
provisioned keyslot and carry a 256-bit DUN. Key management and crypto
capability discovery use the block device control virtqueue.

The control virtqueue is defined as a generic framework so that its
buffer layout and queue placement are independent of any particular
control command. Inline encryption then builds on this framework with
explicit crypto command formats, capability validation, and keyslot
state semantics.

All key related operatios are handled in the control virtqueue, and
the crypto I/O request is handled in the request queue.

For background on inline encryption in UFS and eMMC storage, see:
<a class="moz-txt-link-freetext" href="https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/block/inline-encryption.rst">https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/block/inline-encryption.rst</a>

changes in v3:
&nbsp;&nbsp;&nbsp; - Add a control virtqueue
&nbsp;&nbsp;&nbsp; - Move key program/evict/derive_sw_secret/generate/prepare/import to
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the control virtqueue
</pre>
                          </blockquote>
                          <pre wrap="" class="moz-quote-pre">Thank you. This was a big change, especially if you already have an
implementation. I appreciate it!

My main feedback is that the new control virtqueue commands are not yet
documented in enough detail so that implementors could implement them.
Once you've decided on the precise semantics, error codes, etc and added
them to the spec, then this will round off the inline encryption
feature. I look forward to reviewing that in the future.

</pre>
                        </blockquote>
                        <pre wrap="" class="moz-quote-pre">Thanks a lot for your comment!

Would you please help clarify what the precise semantics are about? detail
introduction of the filed in the inline encryption control command struct?
like struct virtio_blk_crypto_key_desc?
</pre>
                      </blockquote>
                      <pre wrap="" class="moz-quote-pre">By precise semantics, I mean specifying not just the constants and
structs, but documenting what each command does and how it can fail.
Each of the key slot programming commands needs this. There should be at
least one paragraph for each of VIRTIO_BLK_T_CRYPTO_KEYSLOT_PROGRAM,
VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT, VIRTIO_BLK_T_CRYPTO_DERIVE_SW_SECRET,
VIRTIO_BLK_T_CRYPTO_GENERATE_KEY, VIRTIO_BLK_T_CRYPTO_IMPORT_KEY, or
VIRTIO_BLK_T_CRYPTO_PREPARE_KEY.

For example:

The VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT command empties a key slot so that
key information is removed and the key slot cannot be used until it is
programmed again. The key slot index is specified by struct
virtio_blk_crypto_key_desc \field{slot} and all other fields in the
struct are ignored. The command succeeds with VIRTIO_BLK_S_OK if the key
slot index is valid, including if the slot is already empty. If the key
slot index is invalid, the command fails with VIRTIO_BLK_S_IOERR.

Stefan
</pre>
                    </blockquote>
                    <pre wrap="" class="moz-quote-pre">Thanks for the clear example.

I'll follow the same approach and add explicit normative semantics for
all inline encryption control requests.
</pre>
                  </blockquote>
                  <pre wrap="" class="moz-quote-pre">Can you please explain why we need to introduce yet another VQ type for control?

We've added the Admin VQ as a generic VQ for control operations — I'm not sure why it isn't sufficient.

Adding control VQ to each device type seems strange to me after adding a generic Admin VQ.
</pre>
                </blockquote>
                <pre wrap="" class="moz-quote-pre">Thanks for your comment! And I agree that the Admin VQ should be considered before
adding another device-specific control virtqueue.

My understanding is that some of the inline encryption commands(get_crypto_modes/program key
/derive_sw_secret/evict key) are runtime operations of a specific virtio-blk deivce.
In particular, different virtio block devices may have different storage hardware sources
of crypto modes, and keyslot programming and eviction are invoked through the block device's
keyslot manager, and the programmed virtual keyslots are subsequently referenced by the
encryption requests submitted on that device's request virtqueues. These commands are
not about the management operation of device group.

There is also a transport compatibility concern. The current virtio SPEC states that
'Devices and drivers utilizing Virtio Over MMIO do not support VIRTIO_F_ADMIN_VQ'.
virtio MMIO is extensively used, so using the Admin VQ would make the feature unavailable
for that transport unless the proposal also extended the MMIO transport.

For these reasons, currently I believe that a virtio-blk control virtqueue is the better
fit: it keeps the complete key lifecycle associated with the block device and remains
usable across the transports required by the feature.

I would appreciate any feedback or insights from you and Stefan on the V5 patch series
posted for review before October ASAP.

</pre>
              </blockquote>
              <pre wrap="" class="moz-quote-pre">Fundamentally, it does not make sense to force all vqs to be admin VQs.

Admin vq would make sense if there is complex resource management going
on - like what is happening with all the flow control things in the
network device, since they have extensive functionality for managing
device resources.

Random device specific commands - I am not sure we want that.
It remains to be proven.
</pre>
            </blockquote>
            <pre wrap="" class="moz-quote-pre">Admin vq was added for mgmt/control/admin/non-DATA_IO operations.

Fundamentally, it does not make sense to force random device to create new control VQ since we already defined admin VQs for this purpose.

We could have introduced control VQ on each device type, but we didn't.
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">Thanks for your comment!

My concern is that these inline encryption commands are tightly coupled
to a specific virtio-blk device rather than providing generic administrative
functionality.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
We've all the needed plumbing in place in the AQ for device specific admin commands - see virtio-net specific admin commands.

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">
GET_CRYPTO_MODES exposes capabilities of a particular block device, while
PROGRAM_KEY and EVICT_KEY operate on that device's keyslot manager. The
resulting virtual keyslots are then referenced directly by encryption requests
submitted on the same device's request VQs. The entire key lifecycle therefore
remains local to a single virtio-blk instance and its I/O path.

My understanding is that Admin VQ was introduced primarily for device agnostic
commands. The GET_CRYPTO_MODES/PROGRAM_KEY/EVICT_KEY control commands appear to
be inherently virtio-blk-specific rather than a cross-device interface.

There is also a transport consideration: VIRTIO_F_ADMIN_VQ is currently
unavailable for virtio-mmio, while the proposed control VQ approach remains
transport-independent.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
This limitation was introduced because we didn't want to add more noise when AQ was added (it was already a big change).

Nothing really prevents adding AQ to mmio transport.

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">
For these reasons, I currently believe a virtio-blk control VQ is the better
fit.

I'm appreciated if you can give any feedback about it.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
I think that the correct path is AQ.

Introducing another VQ type for the same purpose (mgmt cmds) seems weird and make device implementation harder.

It is much harder to implement a new VQ type than a new opcode in the existing AQ.

</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Thanks for your comments!

I agree that reusing the existing AQ avoids introducing another VQ type in virtio-blk.</pre>
    </blockquote>
    <p>I'm glad that we're aligned on this one.</p>
    <blockquote type="cite" cite="mid:01f3caa9-a1c3-4511-a104-7179ce1791f8@oss.qualcomm.com">
      <pre wrap="" class="moz-quote-pre">

My concern is that AQ is currently not supported with virtio-mmio, and adding such
support appears to be significantly more involved than introducing a
virtio-blk-specific control VQ.</pre>
    </blockquote>
    <p>I don't think that this is a good enough reason for introducing a
      new VQ type in Vblk.</p>
    <p>We need the best spec definition, one that will serve us for
      years to come, rather than worrying about 1-2 weeks of additional
      effort (to a task which is completely orthogonal for adding enc to
      vblk, IMO).</p>
    <p>The high level spec enhancements I envision are:</p>
    <ul>
      <li>Allow ADMIN_VQ on MMIO - Remove VIRTIO_F_ADMIN_VQ from the
        “reserved” MMIO list. Update the feature-bit text to align.</li>
      <li>Add two read-only registers to the MMIO register table,
        mirroring PCI’s admin_queue_index and admin_queue_num. They are
        valid only when ADMIN_VQ is negotiated. My suggested offsets are
        0x0c4 and 0x0c8, which appear unassigned in my version.</li>
      <li>Reuse the existing queue flow. PCI’s rule refers to
        num_queues, which MMIO lacks. So either reword it as “admin
        index is above every regular queue index and index plus count
        stays within 0x10000”, or add a NumQueues register.</li>
      <li>State the Self-group scope - An MMIO owner device supports
        only group type 0x0. Other group types fail with INVALID_GROUP,
        following the existing validation rule.</li>
    </ul>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:01f3caa9-a1c3-4511-a104-7179ce1791f8@oss.qualcomm.com">
      <pre wrap="" class="moz-quote-pre">

Given this constraint, Admin VQ support in virtio MMIO will impact the inline
encryption support on virtio block, so, I prefer to the virtio-blk-specific
control VQ as this requirement is a more widely and general request, especially
in the virtualization platform with a Android guest virtual machine.
</pre>
    </blockquote>
    <p>This is not a constraint worth considering a non-optimal
      architecture.</p>
    <p>Creation of VQs takes device resources. We prefer not introducing
      new VQs if not needed. Adding a new opcode is more reasonable for
      your requirement.</p>
    <p>Imagine a block device with N resources for VQs: N-1 for request
      VQ and 1 for Admin VQ. If we need to introduce a new CVQ then it
      will be instead of one request VQ resource.</p>
    <p>I prefer having a correct architecture.</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:01f3caa9-a1c3-4511-a104-7179ce1791f8@oss.qualcomm.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">
</pre>
          <blockquote type="cite">
            <blockquote type="cite">
              <pre wrap="" class="moz-quote-pre">But generally why does this go on a special VQ? Is there a reason?
</pre>
            </blockquote>
            <pre wrap="" class="moz-quote-pre">Also in other related protocols the key mgmt goes throw a NON-IO Queue..


</pre>
            <blockquote type="cite">
              <pre wrap="" class="moz-quote-pre">You define distinct request types seemingly and we are not short on types?

</pre>
            </blockquote>
          </blockquote>
        </blockquote>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------YqREdxC6iTFcvhNs1DaX1RbX--
