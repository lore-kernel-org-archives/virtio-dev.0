Return-Path: <virtio-dev-return-12520-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85F1C77B78
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 17:24:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0B3FBF936B
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 17:24:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E08D79866B4
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 17:24:03 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CF93A986594; Wed,  3 May 2023 17:24:03 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BC9C79865A1;
	Wed,  3 May 2023 17:24:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iswzAyK9cXZBNY8tiKfJZDM965RkpXNqkiNfK8cQ6QaK7GuWeLauYFa9hS7cKvVeH4D1NsF6yXtKU3APFlpuFUOvVHbeV5cVo30U5I7Z5v7ia+MdUtGLfTiwahian195MSZkGopwSgTev46Zy/uPeOmybehvxQvVtSjPFC4DUulo2jscuHpzY9mkGmBaDwBLjdiGpJ9LdMxSPI4blWnaoE1VYzJ3VVwdVfIx5YIUK4Rv5H212OQFKK87paU+KwHdGu7o8rCxuNTVCn+VNYqlSmRR5LiR6Dch0qooVavBzEVKFomfgDyHlWWV9mKJaHw3XlDNhPmzb2zHBYHuLwxY3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOfQ02eF/q9ZXF3aijdSyOonJ0bEuiK6Fo2SW+n1Jvw=;
 b=TRaYYz+hvZnuCzVMsObgeUr9vLsC2YKnmTIDsf4AuDAXoSqwsDNUtM22q5KDmKS0Wns8kleIqc/z2O9pmJkrzWbyd2YOKFHgmGDdA3ZmiLwcz8siSJjS1qcbPDDr6agNUEkAKuRGS5qfpCXOX/bp4b5xtmtxtYb+WLluH9ApOm4sPcd69oANaNXQyoYXTOhvGKUWAFNAO9t9PXSV/ASnjiZL1D7jYX6hGwfaGHiO+2twqmsD5LUsxuYFwIWpayZzACLjFmig2D4+28WatJNC0aV2hRQsx6ycrqBhAFq9qsR/tVeGQYJ92dLfzMLh60uFmIGU0RZ0hn1FhM32qisDfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <c7cf0054-cfba-57d4-6a3f-bf774751994f@nvidia.com>
Date: Wed, 3 May 2023 13:23:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
 david.edmondson@oracle.com, sburla@marvell.com, jasowang@redhat.com,
 virtio-comment@lists.oasis-open.org, shahafs@nvidia.com,
 Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>
References: <20230503032659.530330-1-parav@nvidia.com>
 <20230503032659.530330-2-parav@nvidia.com>
 <20230503014838-mutt-send-email-mst@kernel.org>
 <36e8746e-9edd-7998-3381-9cee2457f3df@nvidia.com>
 <20230503124848-mutt-send-email-mst@kernel.org>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230503124848-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0151.namprd04.prod.outlook.com
 (2603:10b6:806:125::6) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|SJ0PR12MB5502:EE_
X-MS-Office365-Filtering-Correlation-Id: cf956d51-7e2d-4187-7bbf-08db4bfb2dda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FsBpmD+iPjP6AaD0Yv0fQsNPNiuqdxPhnhtUtLuJvIcDhgBly6P/Pp6/RMvuerZQ6lHJYO4EvtXOcymqKx7r8LdwlEXm4A5BHPGYzyt0H7YBnJ6ZjLoUmqEM0w7Lp9n3gKmM0pN4vqldhw+wFybGp0l6UNFniWiGdJrwnidYWzeX9u3p+pLDPsBpaGsfkxxIWh6x/Q32efjlt6b6WYK1vhKIDQkCMP03FEJ5tTKGO3W4TcE9rWs30hjyUYZx7wZuwLKK4ePZ2uheZvhl+stGMvaL8pi3CGsaoDFvJsXFcN7khCsSAwPuBmTj2e8xImw9adeXUdhRivysv9gMy/O4TL1pZXXrirLT08cYCbwaFJXYbORQIFojeFCgyQnliNc7vpIRV5d0jjc+v2137HDzPLWRmiyBVWCZMqL68G5my31dtVGMPxiNRzck70mXVB7EZTt9SfUUuux/I7b9PDBf5+rJMxxicRr87coxYmzcArk5vXH0RiL/GPJRIHe2GU7PD8RVjrPmIONJ3IeDMUDe/bjSW7+0ipgzCpcGU7/qnSGqGW2ZqPO4QyX3dPG3H/pX9QELHLBnagpFZgVngoMcvA8c22nR3+olpFGnwVyLUGb1kmG6yHM5nF6CKdnxUMURRnO77+To/NgbXFSVFJY9Tg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199021)(53546011)(36756003)(107886003)(26005)(6506007)(6512007)(8676002)(8936002)(2616005)(186003)(5660300002)(316002)(66946007)(66556008)(66476007)(54906003)(4326008)(478600001)(6666004)(6916009)(6486002)(41300700001)(38100700002)(86362001)(31696002)(83380400001)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWo3RHppUCtpeGsyVjg0cUpJQ2xEZ3RNdzNYdW05aFpLRHZ2eHVYL0FsOHkz?=
 =?utf-8?B?MEk1U1pCdEdHWk5PaTRrdHVQRVZGMHllTUJlUFlLQjV0dDIzVC90UjRNWktH?=
 =?utf-8?B?OHAvYnZlbkoxc0g5Z1VpcmIrRjVKWWNNZ21YKzB4aG16TlNoa1RFczh3WG5Q?=
 =?utf-8?B?LzRPQ1ZpYm9OSDN3THVPSXBsNUdSS1QwWXVBeEo4WENUNDBGZEZzY1h0QWsr?=
 =?utf-8?B?Tm9GWlRtNDBIeHZhOHZHNEpNeDVabWxldmFpeG5YVytua0xsc0hsR2tEb080?=
 =?utf-8?B?Q2J0ZkpwR0JoeGhUcXUwN3FDYVJNRUF2R1NIeE5QTzVZaVhOV0VkVDJ6TmhM?=
 =?utf-8?B?allKNnFsMXEzWVdmZzEyalMzUXlOQlpIbmJQV1FtYmx6VVMyM2hsRWVwSkMw?=
 =?utf-8?B?dkpCTjNyWTVxWUpWdjJ2WE5zVk1SSnRwbW02MDJFaDc1UmJxRXB0WWJLM2Y1?=
 =?utf-8?B?RGRCZnMrNHhtSDdQRWFvTVhTbjYyb1Y1T0YvdFp1UWZnamF1bWdXTkVveWk4?=
 =?utf-8?B?cW1XY2h4a0s0NTN5SGlUdUhIcEtSYWptSzc2VHZCRjg4WG1Oa3N2M05EWFQ0?=
 =?utf-8?B?VURJRzR4M2dzTG1TWnRlNW9lRlBNVWZVRVNaU1Babzl1OGFEaHhpemlZZnBB?=
 =?utf-8?B?L29mVFRON0k3SlltQ2hFTnl2V2tDQldTOGhiS1ZVWmM2ZDBMU0x4ZkxtYm51?=
 =?utf-8?B?L0F4bGwza1lzTmU1cThJc2V4Yng0K3pEdnBsem5YNk9UT1ZibVBEQXh2Snc5?=
 =?utf-8?B?UUJ2TDNaQmNQVWZodjBIUFlkWUhJcjFmTjh2V1hQeVNHaDcvZjV4L1B5L045?=
 =?utf-8?B?SWcwNUdrL0dkWXphY2NmQzlPd3FLMHB3T2JpU29Lck9JTXp2M3dzakxDOC82?=
 =?utf-8?B?M3VQRnpwaTR5UGNreFVZbkJOdlVMSStId0JaVTlhWVduSDdlbnIrcHVTZUtv?=
 =?utf-8?B?SlRJNkY1L2F4bU9oTnNoK1BqZS9CaVFQNlFYbndPWjRGNEMzTGYwbWNUYjNs?=
 =?utf-8?B?ZFBvWnZVQ29OaXYwdGJ1bWxmeWhUQjFXaWF3OUFNaTl2Y294dGVRd3laUlM0?=
 =?utf-8?B?ajgwSS91NGNEa1ZMUE1rSHViclRnalR5QU1TTzY2UklBWk4vcExJNUJMWEhn?=
 =?utf-8?B?S0IzdVozc0F5b1d1TisrbmMxMjQ4cmk5ZnNnTUFDd0s0K1JxeFZPVFlpaTlO?=
 =?utf-8?B?cHRya1EwcVRSS0VRTEsreXplMXloMGV0ZlRkN1lLMTFGUXhyTGFTc3hCQXBV?=
 =?utf-8?B?UG02Tm1jZ1pGajN6MFRIL3ZDOXlUblB0SmlZczNKZU92QVRmS2JQWENWdTdY?=
 =?utf-8?B?cFpzYk1QdVVWQldlbWhjNkNmNVJMRkNwM0lkbC9VbUM4L0RlS1VZNzZzY2NK?=
 =?utf-8?B?Z1BVQlJvWGo2NmVJUXVSSDYrUTlIV2Fab0VBeGpVQ05QbGxWNklKaVRSeXhS?=
 =?utf-8?B?U1BQTDh0cktIdnFzNUhYUWw5bjhFdXk0dWRMb29ITTI1TkFicllkNzFSZzBX?=
 =?utf-8?B?Z0k5R1lLOTlNMXFnQTI4SXVuT2ZpbEd6Y0crNmgxR010aFAwRHlPUFY4K2xM?=
 =?utf-8?B?VkFXWlZUajF3Nytmek4zMWsrK0JBN3A3WFhUY3NOakhkUG1NSThwdjhLNVZP?=
 =?utf-8?B?M0pLZW9pbjBRNkpLL2kwckxVWmxTcnRtdkxsN1BOY2tsYWlibGV6L2NKK0xN?=
 =?utf-8?B?T25zQXY3cHZ1alYxaEJtMTVsU2x4UFVQWC9BN0MwSVlqbEp3QzNtcmpPL0dv?=
 =?utf-8?B?dWZDMERkVFVTNUxUajl4ckc0MGtmelp0WWc3R2s2bDFDc1BJWExNNGVaWlZp?=
 =?utf-8?B?WHA4MndVdHNvOHE1cWhSQUFrZ29jVXdLMXcrMlZQdXFsbEV5MFM3V3QzVzQy?=
 =?utf-8?B?SFp6NE5EbGozRFpyT3ova3loVjFLVERHcCtKRUhUNEhkNUdWUGkwNHVjUVR6?=
 =?utf-8?B?VVVGQzNMN25BbSt2cjJkTFhHckVQQkw0b1dsTXo2eFFuZ05jd2RJcytNSGRQ?=
 =?utf-8?B?eFFyVDJuQXpsQ0RmUFR4a0NuTytRTkliTnRYZFJnQmFyS0Q1ZllzeFltRmp1?=
 =?utf-8?B?Q3hqS2ovaTEyMkhMNjVjd2ZnNFduMlBvRGxsRExhc3hmaXhnVHZRYkRhQ0lk?=
 =?utf-8?Q?o7T8IMC+Xjj0FefqEKL2ByaHC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf956d51-7e2d-4187-7bbf-08db4bfb2dda
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 17:23:58.2444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PxfYcF8oszYSjUYpTMeg/PBXh136a4Rg71KhDZc7Ytv3ia39fnLbRkS057Q1ZcIPXk0jX9g/W8VbyUM9pUnp1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5502
Subject: [virtio-dev] Re: [PATCH v1 1/2] transport-pci: Introduce legacy registers access
 commands



On 5/3/2023 12:49 PM, Michael S. Tsirkin wrote:
> On Wed, May 03, 2023 at 10:49:14AM -0400, Parav Pandit wrote:
>>
>>
>> On 5/3/2023 1:50 AM, Michael S. Tsirkin wrote:
>>> On Wed, May 03, 2023 at 06:26:58AM +0300, Parav Pandit wrote:
>>
>>>> +Legacy registers write admin command follows \field{struct virtio_admin_cmd}.
>>>> +This command writes legacy registers of a member VF device. Driver should write
>>>> +appropriate register \field{size} depending on the width of the legacy
>>>> +common registers or device specific registers.
>>>> +Driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LREG_WRITE.
>>>> +Driver sets \field{group_type} to 1 for VFs.
>>>> +Driver sets \field{group_member_id} to a valid VF number.
>>>> +
>>>> +The \field{command_specific_data} has following listed structure format:
>>>> +
>>>> +\begin{lstlisting}
>>>> +struct virtio_admin_cmd_lreg_wr_data {
>>>> +	u8 offset; /* Starting byte offset of the register(s) to write */
>>>> +	u8 size; /* Number of bytes to write into the register. */
>>>> +	u8 register[];
>>>
>>> And maybe add
>>> 	u8 reserved[]; /* structure padding to multiple of 8 bytes */
>>>
>>>> +};
>> Thinking, what do we miss without the padding here?
> 
> it's not 100% clear where the padding is.
> 
It is same as rest of the other virtio structures as described in 
"Structure Specifications" section.

"Many device and driver in-memory structure layouts are documented using 
the C struct syntax. All structures
are assumed to be without additional padding."

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

