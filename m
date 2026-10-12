Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011028.outbound.protection.outlook.com [52.101.52.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FE5397B09
	for <virtio-dev@lists.linux.dev>; Mon, 12 Oct 2026 23:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791846742; cv=fail; b=H3rnsuFFIRKb20Rc01wXFp5YdQDDtd91GZvP6ZG5ykaGM/bWuwyv6UoOFvERe/ix7gUCZcSPpUSEsdPdtnp+EPFSTyHGAIQHXwJhLQmIG2oxzMtyr2wWme0rrrEJPuucXugZ1YJErEzqxUswsM8IHAaXZt7UYdw2nNS0yHBIhWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791846742; c=relaxed/simple;
	bh=LWPzrYGHsFybhdJYW87MDQeKeskI3ABrlahWYtvKZ7g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y34S3VH0bG9YppzrcengtcfiJasgCm1uFChfcLs6zr9yq5554S9kqf7uozv1/P5vObbcXdK+yHdu36PceioBoYyWEF/lmLuYYZxs0pXg65joRbkGH0gGUqfGmPqmbePzLhmVtoX1iNHHPaOO8Kem7OBAATVJpnmb5RpMdGG2BgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X1bB7DCE; arc=fail smtp.client-ip=52.101.52.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X1bB7DCE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNfnEz1ZzzhDGbCpWxKO1/BMgFyFyYacH5x+sLmOtQhKlHFxbkoIdC7KLbB79rMB9QNgNwEDqDb9XmpPaADYGw4OS9DG1Osv5lPzYDQLUZed3CJk0/r0kPaBZddC8DxnJ+vhoSVxwILUxlKuksOxI/auerg+4gS2l6viMHMKhs6Oo0+UlpEY+0s8H3iqRAdUmfCJBuNaYNJ84QZAuMKkqQEkAZ3iBDi4uBs3alGtPDR/LQ/xRJJHkwtjAwiTeZTLEoFIAQsaLF6xJAdx6cFS0HmwDW85/ncKbekoFTdtrekyuy2HbB9eN1Rbi6uV5z3RKZDE+gtAnyaqHdDnN28W6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Krx8XD1RUi0s+f02ANT02ETdnrQLbjlyEdgM0TjSzow=;
 b=eda7Zaf5xOmyxDGxNE/Nd7/9mmRPpLy8/1VTn5w1r+H0nKitYai43Ve4Z0uD8NQcyOyI8IM8igfdY9VLgxgTz4TsZ9gmMbZ2ZauMpi7SeF4bqazrcebfK0MYHyzSIhQNkBIYrjDgnfvEbyAaK1sVFtrbevXAeIYPQ8XJCmyxNrViDYxh4YIi4BLbvr+oOb2PzpW40C6/zQMt1lCv+JI6VfsFTyIC0iQZnRAgTc9TWAZELAvUsCmqtOzMaNzorkc6O/+mMhceky4+gPgJEfRKe/NesZ10Yhf51iQBBTayXLeGopPCjo8TEDCgOCXC0F/5w6pULBgJHz/aQtxUXAJVqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Krx8XD1RUi0s+f02ANT02ETdnrQLbjlyEdgM0TjSzow=;
 b=X1bB7DCESUTCPZidOOoJcGZM9NiWCb5RTw2LV4nTfvxEvfor5bKWl8O/rxkmadf2lQnSdTrNy9oaiNA8ruQE9rn8EmT8OW/kk+9OQyNbDN3bWIwy0cpH8UNoDAT5Sn537Du9QDXzPLV/SomgsW2kagF1S2lSqBHLxefc+Dwe2N1J1ZJLAkaihn2uTSNuwHceVcwkNk2lJkV7H8BsE6tZntDQg79m4iJfg6L1EtUBCLgj8LKaqYeyyW0FRkZMWD4Mt8ztrw+c64fxu+1dl5Ygvrw2rNV8OtF19r/+dMy/U8OwDtTqek4s6oI+aqGkbLd1DxzRgnb/peofwfCHm2as4Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7558.namprd12.prod.outlook.com (2603:10b6:8:133::21)
 by DS7PR12MB5885.namprd12.prod.outlook.com (2603:10b6:8:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Mon, 12 Oct
 2026 23:12:14 +0000
Received: from DS0PR12MB7558.namprd12.prod.outlook.com
 ([fe80::96ea:b67a:4a5b:85e0]) by DS0PR12MB7558.namprd12.prod.outlook.com
 ([fe80::96ea:b67a:4a5b:85e0%4]) with mapi id 15.21.0496.021; Mon, 12 Oct 2026
 23:12:14 +0000
Message-ID: <d503aee0-9920-4c0b-b9a0-c08e505cc3ea@nvidia.com>
Date: Tue, 13 Oct 2026 02:12:09 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] virtio-blk: Add inline encryption support
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Linlin Zhang <linlin.zhang@oss.qualcomm.com>
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
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20261008060644-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::14) To DS0PR12MB7558.namprd12.prod.outlook.com
 (2603:10b6:8:133::21)
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7558:EE_|DS7PR12MB5885:EE_
X-MS-Office365-Filtering-Correlation-Id: 3db662c7-33cb-40c4-bfaa-08df28b64054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|6133799003|22082099003|18002099003|10067099003|3023799007|4143699003|11063799006|5023799004|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	7DmONRR8RKBpoL+3woWjLRyW8Eqc1qS0c+E4SMIAGIRE1YXpbVjoyi33gLAer1E3pvzxAd3D7Vg85Dhd8ny7Rm2JDKuJAuRi9Xq7AoD+jgPqO509BsOKiUSz/Kn7k0UBvFuMDR9iqDR4sTI6H7wWTUJVHMOtGl8SN6DOANycuxMWC2d/mXFvm/TCrCsRE1Xggy1rRWxI5oeezpxaKa1hGYcPLhu086Nqb2l0SU1ffdSml4lf+/UUq24IPR0U6jO0uuQVStS5Dzc/eLGsRidZkss17VYJC0Atx8dMgzt0Q7Z8yQB+yR5+mP6USE2kpiqDYiFBn5gqm2gveSt/0Tc2qmmW3i39MaXhgT7CcnvPTV8bcDe5MetmjI+72mTOqYw1wukKZtSIXYXHE+m6i3901YT4S+w9Y2NXgVUMIRE+biJu1gpxCHzzE5fI2MtVumUzlG4SYkESHywl/k+J9FM5uCRxG9phnlapQfziFekHU1pMijpVVNgD4KAoHRX/b+hZpU58BpBgWPs7g5JBYTpy8UOlWiiH4XvX/GrkglFjVvRNXtAFU4Ilvu9ij2AW3mPgt6YRrDen6AccRJ0Rg3RWq39cebUu3Xb1ezWNdI/43xoyTZPskGE0WegDYbvKTZGkBaHxcOzCe6BloJV3I/fiJa2dDF2VDzsthYJ3/hs58zo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7558.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(10067099003)(3023799007)(4143699003)(11063799006)(5023799004)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnNSYU1pTmVPZDBqdmpvSFprTDNkV0ZtNHdBUTJ2dnhDcitDU3U5Uy96ZGxs?=
 =?utf-8?B?UitVRXN2NlVXbmF0eXlrbDRhMWxwRnFLWjRVWkR6UUVHWWNFMEFPODlVSHp0?=
 =?utf-8?B?QzFsUWk0QnVMYmdaVHRlcVhWZnJzeGRscStudmhZMzRyS1M5elF5eGJac05X?=
 =?utf-8?B?c1ZXWEU1Nm9tdUFPUk05bUF1QXRMN2VIMkttLzlNNEJVaFpkS0JHUWJOZGc3?=
 =?utf-8?B?UTU3QWc5aTdMOU90VUZYUmFlTkFsM1NHNkd6d20zQXhNSmpRNng4YUtRbkZs?=
 =?utf-8?B?WnJ3emFSc2NFWmY1MWcwSE8xMjcrckVCTkJkTFVWVjVhd0lKWVg3eEdzZGZr?=
 =?utf-8?B?N1dtYjRyRXBHL1VPTlRldHRZVWNSSnhrNjF5bFdOR3NmTzlVVmdwR1lWSUEz?=
 =?utf-8?B?Q0U3U3pFUk1ZWTNKUnU5Y2dleFlCeC8wVWV5dEpFNUtjRDB2dWpySENTdWVq?=
 =?utf-8?B?RldhR2xTV2RCMzFqL09kUGhHcnA2azlJczBLL1pxTy9hQXdjQW9DWFpsZzlV?=
 =?utf-8?B?S2xjRTdxTE0xQzU5aG1LdnUvOCtPakZUdk9QeFBSNjdTVEpBUUFtZDZqSkpG?=
 =?utf-8?B?Wm1BUURRelkydnNQdlRRZnV5ajJtd2Frc1lTVXJLMFBkQnBMV05KVEVlZDZj?=
 =?utf-8?B?MUVDVVZkQnBrNno3b2Z1MU13N1pzODFBSG0zRWtwMytDRnRIZVVLdENSalcv?=
 =?utf-8?B?SENHS1ZvTyt1dmFrNEtqMWM2b0Nld2RJcHd3UWhVR1FzZFh4RGUzRlVuRmR2?=
 =?utf-8?B?SGZmSVk3QWxBVFNtU3hyVnlVQVlvRzdEQkZ5QlNQdWs0Mk9hbGduOUUxa1ho?=
 =?utf-8?B?YnZxZzhaT0RVNEhGWFNJRGpPTUNzQjRCWGs3ejRBM0RUZ1JWMzQ2cHdXcUl0?=
 =?utf-8?B?QlJZeTZsZTE0NXNCNlFVRzBPdUxuVWhyR0JhYjgzamR0Zlp6VUFSSS9kajFG?=
 =?utf-8?B?MkVHS1JlZEVTNlV4cEc2cmNXeG5ob3RnVEdYQ2w2YWI0MzJGZVNYSUdmUTJ6?=
 =?utf-8?B?NktUNHJ0YXZ4dE1IakxPTG4xdk5EKzYrZG15Nm9hb0dNRTRseUVsTldrTnhh?=
 =?utf-8?B?VGNCNFVVdUxtWGF5WnFSMmFlMGd2NjJYYVdRcEFKL252NzRPZnhkOXlpbUtL?=
 =?utf-8?B?M0VZcVFJSVc4YmdaQUFsb0E1aHhCVERpUWltazdCT0dwKzFZdVhrcU1QdjMx?=
 =?utf-8?B?a0ppZUtFZWNkUkJnVjliOHhTRmxsRVF4WTNYa2tpQUZNMmZXcitsdEczSktz?=
 =?utf-8?B?dmxBd2Rqd3lBeElia1ljMUJnamYvM2lVTXBpV1dqa0p6b21aZ3MrVkVnMnF3?=
 =?utf-8?B?TFI3NXpZeDlYKzBRMUduL2x6aHpIcjNaTlY1NUpMQVVLQjZKZEMySWRYNnpL?=
 =?utf-8?B?Z0l2QTErN1lHQ0FVVzZLS3g0cnExRzRDSmdEMWgrUWpOTUp3bG1SeWsyK0la?=
 =?utf-8?B?YTM1WHRPSmtXbC91bVpIUDE2clZKbk5pVm9HUzFORU5TQW1GbjRTTlRkd043?=
 =?utf-8?B?T3MzTk01RlBINlM3Lyt6Q05xLzhKUUFEZnI1cG1va3FSVm44OXpVaXFSUkJG?=
 =?utf-8?B?MmlaRGRVdnVEWjBwYlRFcjhlK0UwUkZXUU1tK1ZEdmpxM2ZwQjJVQ3ZKdEQx?=
 =?utf-8?B?K1N6c25ISGh1dTh5NjBJM3VUdzNBZnpSbElPcVdJVklzRmtsT21BS0ovRm9U?=
 =?utf-8?B?OHpvTTJqV0NaQ2czalpmSlI0MTIvVGw4SnVIU3hmaGQ0MGo5ZXkxNmoxVndT?=
 =?utf-8?B?VFJuSjFEMkZ4QU5UTjNydStnZGlIckhvZGYyeUw2YlBNVERrZkMwWXRzVm1N?=
 =?utf-8?B?RnlhbVhOU3B6UW9RU1BFRHpvVC92Mkt3VW1LSlYyYnkyeFN4L2dHZGl1NktK?=
 =?utf-8?B?b3hsVHBXbTRqaTd2UFFSQ2lWTElyYlVNS1RoYk55WVhvLytaMjNiOTFSazZn?=
 =?utf-8?B?RVh0Ynpid3dGTGNKRGE0ZWtJOGpWMjkyOGhrN1hQeEtmYnZZYTVwWG9uWnhs?=
 =?utf-8?B?Tk9EdE9jbmVJWDJWRGxvMVozNlRMYzJlWExPWEJKdDUyUG1uVWpzWUJXSVg2?=
 =?utf-8?B?YXBKRkFBWFhwdm1aVS9wanhSaCtoTTd3enRTYis1UlZJekRKTGh5MGxlcHdI?=
 =?utf-8?B?V1M3QnlLeG16bUxkU3dwVXVSVTNZSUxVWmJ3M0JnaFh1S2pMUUdHN1hpRHhP?=
 =?utf-8?B?RUxTa1grOXFlSGR4TWovZnZFRE9ISGFmQ3ZnZXMvR2ZBVGhGaEVWVloxaXdZ?=
 =?utf-8?B?bUdKQWYxeXVGM2p1Ni9LQnV2aC8vVGdrRTgrR1h4aTRjbmF0YytmT1dwL3ZI?=
 =?utf-8?B?aHB1bThleTFUY0FNS3pCRXpQQnBDMFB0MFpDYjBNWnRQZTJGbWVxZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db662c7-33cb-40c4-bfaa-08df28b64054
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 23:12:14.1537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p6xKpdH3w3tw6LvW4fULkycWcENY/4lMORURRDiHer0tVAlLLqRGGgpc8ekpNNJi4+eEYFtGj11IYSw9YOhxIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5885


On 08/10/2026 13:15, Michael S. Tsirkin wrote:
> On Thu, Oct 08, 2026 at 05:17:30PM +0800, Linlin Zhang wrote:
>>
>> On 9/30/2026 6:46 AM, Max Gurtovoy wrote:
>>> On 24/09/2026 12:35, Linlin Zhang wrote:
>>>> On 9/22/2026 9:14 PM, Stefan Hajnoczi wrote:
>>>>> On Tue, Sep 22, 2026 at 12:29:37PM +0800, Linlin Zhang wrote:
>>>>>> On 9/18/2026 5:08 AM, Stefan Hajnoczi wrote:
>>>>>>> On Sun, Sep 13, 2026 at 09:16:13AM -0700, Linlin Zhang wrote:
>>>>>>>> From: linlzhan <linlin.zhang@oss.qualcomm.com>
>>>>>>>>
>>>>>>>> This series adds virtio-blk inline encryption support for devices backed
>>>>>>>> by storage hardware with an inline crypto engine.
>>>>>>>>
>>>>>>>> The protocol exposes device capabilities such as keyslot count, maximum
>>>>>>>> DUN size, and supported key types. Encrypted requests identify a
>>>>>>>> provisioned keyslot and carry a 256-bit DUN. Key management and crypto
>>>>>>>> capability discovery use the block device control virtqueue.
>>>>>>>>
>>>>>>>> The control virtqueue is defined as a generic framework so that its
>>>>>>>> buffer layout and queue placement are independent of any particular
>>>>>>>> control command. Inline encryption then builds on this framework with
>>>>>>>> explicit crypto command formats, capability validation, and keyslot
>>>>>>>> state semantics.
>>>>>>>>
>>>>>>>> All key related operatios are handled in the control virtqueue, and
>>>>>>>> the crypto I/O request is handled in the request queue.
>>>>>>>>
>>>>>>>> For background on inline encryption in UFS and eMMC storage, see:
>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/block/inline-encryption.rst
>>>>>>>>
>>>>>>>> changes in v3:
>>>>>>>>    - Add a control virtqueue
>>>>>>>>    - Move key program/evict/derive_sw_secret/generate/prepare/import to
>>>>>>>>      the control virtqueue
>>>>>>> Thank you. This was a big change, especially if you already have an
>>>>>>> implementation. I appreciate it!
>>>>>>>
>>>>>>> My main feedback is that the new control virtqueue commands are not yet
>>>>>>> documented in enough detail so that implementors could implement them.
>>>>>>> Once you've decided on the precise semantics, error codes, etc and added
>>>>>>> them to the spec, then this will round off the inline encryption
>>>>>>> feature. I look forward to reviewing that in the future.
>>>>>>>
>>>>>> Thanks a lot for your comment!
>>>>>>
>>>>>> Would you please help clarify what the precise semantics are about? detail
>>>>>> introduction of the filed in the inline encryption control command struct?
>>>>>> like struct virtio_blk_crypto_key_desc?
>>>>> By precise semantics, I mean specifying not just the constants and
>>>>> structs, but documenting what each command does and how it can fail.
>>>>> Each of the key slot programming commands needs this. There should be at
>>>>> least one paragraph for each of VIRTIO_BLK_T_CRYPTO_KEYSLOT_PROGRAM,
>>>>> VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT, VIRTIO_BLK_T_CRYPTO_DERIVE_SW_SECRET,
>>>>> VIRTIO_BLK_T_CRYPTO_GENERATE_KEY, VIRTIO_BLK_T_CRYPTO_IMPORT_KEY, or
>>>>> VIRTIO_BLK_T_CRYPTO_PREPARE_KEY.
>>>>>
>>>>> For example:
>>>>>
>>>>> The VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT command empties a key slot so that
>>>>> key information is removed and the key slot cannot be used until it is
>>>>> programmed again. The key slot index is specified by struct
>>>>> virtio_blk_crypto_key_desc \field{slot} and all other fields in the
>>>>> struct are ignored. The command succeeds with VIRTIO_BLK_S_OK if the key
>>>>> slot index is valid, including if the slot is already empty. If the key
>>>>> slot index is invalid, the command fails with VIRTIO_BLK_S_IOERR.
>>>>>
>>>>> Stefan
>>>> Thanks for the clear example.
>>>>
>>>> I'll follow the same approach and add explicit normative semantics for
>>>> all inline encryption control requests.
>>> Can you please explain why we need to introduce yet another VQ type for control?
>>>
>>> We've added the Admin VQ as a generic VQ for control operations — I'm not sure why it isn't sufficient.
>>>
>>> Adding control VQ to each device type seems strange to me after adding a generic Admin VQ.
>> Thanks for your comment! And I agree that the Admin VQ should be considered before
>> adding another device-specific control virtqueue.
>>
>> My understanding is that some of the inline encryption commands(get_crypto_modes/program key
>> /derive_sw_secret/evict key) are runtime operations of a specific virtio-blk deivce.
>> In particular, different virtio block devices may have different storage hardware sources
>> of crypto modes, and keyslot programming and eviction are invoked through the block device's
>> keyslot manager, and the programmed virtual keyslots are subsequently referenced by the
>> encryption requests submitted on that device's request virtqueues. These commands are
>> not about the management operation of device group.
>>
>> There is also a transport compatibility concern. The current virtio SPEC states that
>> 'Devices and drivers utilizing Virtio Over MMIO do not support VIRTIO_F_ADMIN_VQ'.
>> virtio MMIO is extensively used, so using the Admin VQ would make the feature unavailable
>> for that transport unless the proposal also extended the MMIO transport.
>>
>> For these reasons, currently I believe that a virtio-blk control virtqueue is the better
>> fit: it keeps the complete key lifecycle associated with the block device and remains
>> usable across the transports required by the feature.
>>
>> I would appreciate any feedback or insights from you and Stefan on the V5 patch series
>> posted for review before October ASAP.
>>
> Fundamentally, it does not make sense to force all vqs to be admin VQs.
>
> Admin vq would make sense if there is complex resource management going
> on - like what is happening with all the flow control things in the
> network device, since they have extensive functionality for managing
> device resources.
>
> Random device specific commands - I am not sure we want that.
> It remains to be proven.

Admin vq was added for mgmt/control/admin/non-DATA_IO operations.

Fundamentally, it does not make sense to force random device to create 
new control VQ since we already defined admin VQs for this purpose.

We could have introduced control VQ on each device type, but we didn't.

>
> But generally why does this go on a special VQ? Is there a reason?

Also in other related protocols the key mgmt goes throw a NON-IO Queue..


>
> You define distinct request types seemingly and we are not short on types?
>
