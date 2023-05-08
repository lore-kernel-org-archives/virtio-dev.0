Return-Path: <virtio-dev-return-12613-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A9FC77B75
	for <virtio-dev@archiver.kernel.org>; Mon,  8 May 2023 16:55:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id ED92C2B054
	for <virtio-dev@archiver.kernel.org>; Mon,  8 May 2023 16:55:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E39E698640A
	for <virtio-dev@archiver.kernel.org>; Mon,  8 May 2023 16:55:08 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D87519863BF; Mon,  8 May 2023 16:55:08 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C50129863C2;
	Mon,  8 May 2023 16:55:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Os06qdDnF1GFdtdDq/HMF0jiFobRE18iEpODfB4DVn9V4iGExXq9NqgYdZN6n+EYTz7+R4ZzUOjqlaHlRu/QjZpB4yFZs9/plCuoardNJG8accJrN8aFD6ugIhCYuAJT8E0mWm84JKN/tYU+clIszGkPjupao13/fey5r4DAqrUq3ooDVinCZvbpfkppmKzSZrUS0KSWG88aySKtbRIAJ0Ejfd66hCl7XW4EaNMbeTlt0/pMlnweSGTFbX2pqmm4X/kn3yjcr92H/QnlsZroWu6/Hs+5342ixt6At0LEEnfr3LoiVZd2VsWklrDk1SQ4lFyvXzz8nMcYJuzNnPFJ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhCnPWvfwLe11Gqu4N17sVpIWgIJJWAEVYJsK6j0xkQ=;
 b=VAYoH/fu94fL75+3vzVSm71/LfQemapvk+rVk2qeGvHUYHMOEYe53bUZ8ApYvIyHi/Qzw7xy6Xl3LukZBVprnmCGUYCnyfXS8bRAwg/w5vRURQsyVjml2AOqDgoHvaqdtN0YgWQkTPTMS1UwEqioKmjo7ptwjGlF1bPHMmHcEk28nKK6g+RCfupSFrqBqmc2iga6jw/YrAROMNyqLuvbFaVpsb08STqZo8x5anlGx4n+uelGsFWjPqFVJQ/kDGT7Psw5jzf18EkIjIAMyoKTz593772FDKCQOgjeo1QOUfXRKs5SS43fObHqtWjsNcgSH0+vmLsK3PU075ZI1bWm8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <71d65eb3-c025-9287-0157-81e1d05574d1@nvidia.com>
Date: Mon, 8 May 2023 12:54:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
 david.edmondson@oracle.com, sburla@marvell.com, jasowang@redhat.com,
 yishaih@nvidia.com, maorg@nvidia.com, virtio-comment@lists.oasis-open.org,
 shahafs@nvidia.com
References: <20230506000135.628899-1-parav@nvidia.com>
 <20230507050146-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230507050146-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0001.namprd08.prod.outlook.com
 (2603:10b6:805:66::14) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|MN0PR12MB5858:EE_
X-MS-Office365-Filtering-Correlation-Id: af9ce668-8ada-4798-73c1-08db4fe4f5da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/WmZYVR1KTqDRdGskVm3PWa2xJT+uLNFfAHyP3TNOWzmzWjZx3er/hMRHVXnxuXZuPktoAoYrtJHF3XRcCDfCylxmAoOfYEFB4SQ8OAbpRnUWvwV82OChmP5Q7ynZkVLbHm/XhUlMyMcJlt0cfDGEvdjvLhzz2oUWcw8DeWSZNezfT72ndifF5v+AkMfnATH6DXSwkjf+0/qXcLJd82cbkAwlgIkQbAXjJmo2/BKy22eWsbhYQ0smFjEdwfYgYDaHU8y91fM2e01ig6FEBzzg9h474b5JBdLVNPjDfzAGlmmAN8N600GvsKBS1/rspiEdtcIf4W7cQn6V0MuYz5rHTk7EvKLZs1jCy4LNHmMRQEooLWKAlw6YSCin36m3O+PZ1ebnygKqcyBAnHXHXXOnI12pDoUU8X5nsXysM03HaRCnNR1/cXZOfg75/Gu+ff3jE1yvtt3x+zDTu+ldbJ2k4X+SWWKSkFte4wG9ZJmXbYObzY83GIO9E8jwdZdy/FodZ1LZIkMnRxEI/tD7++woa97/vUDNRtqewUBQnHnHq1dPN6do1T1ldlWqjc8u+G26pON9tZUVa9L7xh0HmlS+6gpkz0sQVp+zymcnW3h/hKMdHiUd/iu+YK4xN69bqlZGwFhswo0gtl1+MAGqiX4aQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199021)(31686004)(6666004)(66556008)(66476007)(6916009)(4326008)(478600001)(6486002)(66946007)(316002)(86362001)(36756003)(31696002)(83380400001)(107886003)(53546011)(6506007)(6512007)(26005)(2616005)(8676002)(41300700001)(2906002)(8936002)(5660300002)(186003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2ZOQ2I2a3c0MHlPajVYOENwSVI0dmF3T0w0UVQvbXJ2OTE0ZTROS1A3MEF5?=
 =?utf-8?B?UHJqa21EcytmSml5RW9tVG5xWEFBTnlteStJbUZRVWdJc0VJU3R0aWVrTitp?=
 =?utf-8?B?dHErL010S2t1SHA5RXIyKzlxbUxYeDU3TDNBeFU1aHVrTU5ZYllpTnhVdEZP?=
 =?utf-8?B?Ymk1VHRnbGtNZEhrTGw1bTM3VURlbThGUjJvRUFVZ1N0RGxzMWN4K1RqSENa?=
 =?utf-8?B?ZzEzcFI5YXJFQXBoTDVDWSt3T0xMMnFaSE9lcHhrSFZ4TllVMmR1R25HTWJU?=
 =?utf-8?B?S3dKMHRMaHM4NDBGOC9NSXByVnoyci92TEFTMjUwOXdmSlE5eWxNN1U1Q2or?=
 =?utf-8?B?R09zYkw5SkdKZEE5WXRsOFQ1cDI3NlNNZHdqSkZUNUFmeVVMMkY2SVYrcHRZ?=
 =?utf-8?B?MmpNSmJtWDBScmpCd3NvYUVaamp5SHNsOU13N0hvSzliQmtFK1E3YWJJRGFV?=
 =?utf-8?B?Qitqc0RaUVlZc3BUNFh1VVlBSWNVb0dSZlNuQnhaWUZxZkJORWRhREtBeE80?=
 =?utf-8?B?RnI1ODdIUUlvK2VnalhOUjBnMmJNZDlJNXBKQjZSQnF6V1pObEVBN3Iza0JH?=
 =?utf-8?B?aisxYmlQamFXUXBqSE5YTElUZHZKWnZaVklSVThGVmxWU2M4SXU3K2pWM2Yx?=
 =?utf-8?B?bHNoUks1ZmF5WnJrNkhMTHdtVEhjNnpmck54ZUtCV0c1bndIRzJLc25LMGZm?=
 =?utf-8?B?VjhxcmFCNURoTDJHRHFxMHFNYjBGM29RYnYxa2JGSXMyRUExL0dka0NEckhm?=
 =?utf-8?B?Q3hyTU1yM3FGcmtHRWFXZVVORFhUUUhuM3o0a0FRcnNEKzlHVERmTkpJMllK?=
 =?utf-8?B?c3VrblhQbk0xcHpUazgrb0ZBWmpjNFROejQvU0JKbmJoZ0MxRllLcXNLSnI1?=
 =?utf-8?B?UUdYOS9ubE91WUNRRGdFWlVOVlYxUmtUTmxWbFhxY3M1cG1pYWRNSUFkQml6?=
 =?utf-8?B?OE1MTHhvUWJGcHVNQmtRanlqZUY5UFNPQnFScDdKZ2RSdDJiNFBwOVZZWk9m?=
 =?utf-8?B?UVFzTUE4bzVQclBtalZHS2h5Nm1iV1Z5ZnBVb1BGTnFhYk0xYXB0dTNOTmlI?=
 =?utf-8?B?eFoveEQvd0x4Q2dHV2xlWEwxVTEwRzAxbWIzL2hKc0R4WkdiRlZHYk9kc3N6?=
 =?utf-8?B?azBwZFJ4L1VXaHJsWi84SmRiRTlieGN3RSsxMktVVXFPNFE3aDAyYmhsZUpY?=
 =?utf-8?B?amVKRUw5eElkT09zMXFrbXhTR0lzcFFsWGk4MTlYY2tMQW5FVzBHQjVKdWI4?=
 =?utf-8?B?VFRPalBKOFZBeFBUbFEwMUs3dWJQZG13ZWZsR0NZb0NnbXgxOHptS2N5VU4z?=
 =?utf-8?B?QnBKZFRvSDRDQ000S2NoMXRRcHErcS8rZ1Uwa1pNRUcwc24zUXBzREF4T1I3?=
 =?utf-8?B?eitzeDJ5UE5IelhnbDN6blVIcTRoODh4cmxUVDRsdEUvY215U0NxWi9URWUz?=
 =?utf-8?B?ZzByUVAySEFzZ1VZTlBMMkZpK2lKa0pwYVpsWG1TbjlucU9RcFdUTkdnT0tv?=
 =?utf-8?B?U0syZHJKWnVLS0NpbjVrOWNTQzE4Wm9pWWJnYUMzTVY4N2JOMU1UMXBleUdG?=
 =?utf-8?B?cTZXMFN3V29aeFFuY0NTRm5yU1E3QXI0aU04cGJIaDRzdjFsZFQ4aFBBL1hW?=
 =?utf-8?B?TjFJN056TlVMWWI3eUpxVVhoeDk4OWRnKzdNYlZ1dTNUb3pwVWRINGlCT3Iv?=
 =?utf-8?B?ek1vSHVnOU4vQ0E4VlQwRGJaVUV0ZlR1UzhDY0RnUTFTbjFmK3hxc0Jpaktk?=
 =?utf-8?B?M1Jjdlp5ajVrZkhaTEozK2ZHazl5UlZGS01TT0FaLzhJT0NGVVBxN1I5cFR5?=
 =?utf-8?B?a0NIbE1MOTY0eXZBYVhhZGsxTytXWEVLZW9jclh3QldWMHdyQjV2S1oxR3dL?=
 =?utf-8?B?alQ5YS9ibkNuQzBqK3Z0NnBmR0M4enRvNTR6YmVzcVM0UjFjb1Q1ZDFqUFVq?=
 =?utf-8?B?WnBZTHc2YStOT3RjVDhTWm40S2hOR1pxWi9EMTZPT21DSXhucVRqOUJKQ08v?=
 =?utf-8?B?NngzeTduL0p2Q1grWUt6dnU0eXRVSXZQdkpVTVFFYkZaMW4xSU1ramlKaCsy?=
 =?utf-8?B?UTRlY1JpQzMzMEdiQWIxTlAvM2ZIRTVGT1B1cklvMENWRzZLc2IzQ0Fjc2pj?=
 =?utf-8?Q?ZZQkBhtzwJKs47gEafkcowT8a?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af9ce668-8ada-4798-73c1-08db4fe4f5da
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 16:55:00.1051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VhecA/tQg5Izc5v/GOg30SNTrGPvCJM51f+jEvAHxSVWB9LvrjWCkZJTOaNFaxY8jScBRNzFxFYis6hi1uYnXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5858
Subject: [virtio-dev] Re: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ


On 5/7/2023 5:04 AM, Michael S. Tsirkin wrote:
> 
> one things I still don't see addressed here is support for
> legacy interrupts. legacy driver can disable msix and
> interrupts will be then sent.
> how about a special command that is used when device would
> normally send INT#x? it can also return ISR to reduce latency.

I am not sure if this is a real issue. Because even the legacy guests 
have msix enabled by default. In theory yes, it can fall back to intx.

There are few options.
1. A hypervisor driver can be conservative and steal an msix of the VF 
for transporting intx.
Pros: Does not need special things in device
Cons:
a. Fairly intrusive in hypervisor vf driver.
b. May not be ever used as guest is unlikely to fail on msix

2. Since multiple VFs intx to be serviced, one command per VF in AQ is 
too much overhead that device needs to map a request to,

A better way is to have an eventq of depth = num_vfs, like many other 
virtio devices have it.

An eventq can hold per VF interrupt entry including the isr value that 
you suggest above.

Something like,

union eventq_entry {
	u8 raw_data[16];
	struct intx_entry {
		u8 event_opcode;
		u8 group_type;
		u8 reserved[6];
		le64 group_identifier;
		u8 isr_status;
	};
};

This eventq resides on the owner parent PF.
isr_status is read on clear like today.

May be such eventq can be useful in future for wider case.
We may have to find a different name for it as other devices has device 
specific eventq.

I am inclined to differ this to a later point if one can identify the 
real failure with msix for the guest VM.

So far we don't see this ever happening.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

