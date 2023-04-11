Return-Path: <virtio-dev-return-12124-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11D4C77B70
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 13:48:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E7BB2D56EC
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 13:48:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D8DDE9865F7
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 13:48:02 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CD87E9863A7; Tue, 11 Apr 2023 13:48:02 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BC20198636E;
	Tue, 11 Apr 2023 13:47:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pe8TOlkfhL3chE1Dv4+aFkptgC/mPLsOUl/dNWf80e0xrKlUXPfqucaqenJQELbVzDm+/bdsbQXrt717nTJcBN5Z8W5IesXROtPML6JL3WOc/Pr6pYvFy8cVH+//s+f4iVkLqf/jZNTD5hBnJvjxALJIiFM3aBbmFQdLCVq8dWoEKDUUTm4ZoAnGq4TtHpthJipiPmEMr1u9hc+oq3Kw8IZj1bXdQIZcHMfuV7eWx9Fb6nCTJel49+Wqlv4z8IWjYAecQPFXgGL4/EssAKm2R4zh3QtYckDnXYVfWoB59CUf8FVxyz9QQ48RAtmVTndU9ejmWJTrQ22O9GUEesu5Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8aEqwnnbOiNRlMPswVB37T9qLKWbOrefOOGDl0lCI9A=;
 b=RkZPN6JmFyLIrMtF5Wc38U36AsJIm1kX4HIO2oRZMl//IbpIC+m+S5Y6fv1+3xMiio7QIEhBoFL10ruB8xfR0Lf3ovBxA96/SX/IidhmDt1cXeAn1OymLGaSbaSU1OaS1JdGNAm6j5ozJJP608RQ2y+mWjxJzks+gIpREy+gi5CM/uEdO0ozHmyRoVfEMQ08B2B43Jn+V41SYnzrjtwYtF1mbfmmxSObVRROsVN/t9fdgRM0ScmTs2ilGryIrDXAqLA8RCCje9eHgFEHVO/9PiWRaWDFmiUtE6HsjP36W78kocuLGySgfjlijFXHGL8huTxaIkQ7GERFHV1nuZUFWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <c6e986e2-4806-6635-5d8b-0f70c51c6b88@nvidia.com>
Date: Tue, 11 Apr 2023 09:47:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
 virtio-comment@lists.oasis-open.org, shahafs@nvidia.com,
 Satananda Burla <sburla@marvell.com>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-9-parav@nvidia.com>
 <CACGkMEtMOy4B-O-52ka+9P3OBQ_hs1KvdjWodNYg-XKLff+giw@mail.gmail.com>
 <20230410021619-mutt-send-email-mst@kernel.org>
 <CACGkMEsZXozY7iC7L3L9FC+o8dQGY9+Hhbag2Z-G-nxr9BvDdw@mail.gmail.com>
 <20230410055947-mutt-send-email-mst@kernel.org>
 <CACGkMEsKLeJ1q3Vh8h2JYM=-RcrGd+31yR1Zsw0U=SRd1JZugg@mail.gmail.com>
 <20230411025646-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230411025646-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0603.namprd03.prod.outlook.com
 (2603:10b6:408:106::8) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|DS0PR12MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: f3ceb2a5-928f-40a6-b80f-08db3a935946
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SnCY4pKndDVRC0c8tRRwrswa8m+hT5LntHzlfk1dVU5W6gdtt13216a6Vc7N8RT98OT9Q4X+n+qjibwJnyn2Fl5CI3gWzP+sig+nmwE72Wy5n6efZah3b9BoaoTKxtxfWaAQBsNrIvP939eOWuLab1chiSj07fzK+45pXPOZ4ZdCJ4R084JuMQ8GFEvj1cHwhaoEdjPREzLgzqGS/7S9fUL3qV4SRln5cgiEwW67MCz2uJFSrtmpcC7pnzEluE/8A71dLRdoAyh7gbMSgJQlkvbJUybte+phz+TUkHpYBG3fAvweXlNSiZzViGxC2Y3gd/zNyEdOmz1A0h6MJ4Nx/ixLZO3QhFPGjabEduj8EuhURWJTm+Zr3+luyMr2uVbFnfgbC0kK/OcNGX55ODdVl2S6ebRgqAiuGwwfc9oDumFCw+QysgZkfSbtE6S9pprxd08drn8ZXq1F+wb4jFBZgWhewzXRPbn8XYovJRC9oNsYvYdrTpCRc4iCzTi6BLd5v28GpBrHayB6D8jlYuhUIgZd4Mp5k91PCmue+7wutxBdHkEvYYTNbfSe7jziPOPpoT9IM+zTwjuc340eR0NjLxxpFGEoP8qh/BldyIeaYn61BMuC3ks6s5FuJtmxpT5bL94vBIXgOUVawl0n4kA/rQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199021)(478600001)(2906002)(6486002)(31686004)(186003)(6506007)(316002)(83380400001)(6512007)(53546011)(110136005)(2616005)(66946007)(8676002)(5660300002)(66476007)(41300700001)(66556008)(4744005)(4326008)(8936002)(38100700002)(36756003)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXZtMUFFclBRbFhBVldGTzhaVThYWGsvbFlHUW5Od0NnblNtQzlodjdKVVVG?=
 =?utf-8?B?SFFSbUNLOVRVRE1YekRSdWl5VDI2RThDZmg5QVpRNm5LenNKdWdNekJkNGZu?=
 =?utf-8?B?cVNWeGM4aFUxWWZkZHZVYm56RTY2SXlZZGQ2VHcrYUZocTJqVGg0UHlFcG5i?=
 =?utf-8?B?UTZOMjFRSWhSMUhRdHc0cHJoQVNSbVBvNGI1SHZPOHBEWFo2RWNKcFNDTS9Z?=
 =?utf-8?B?ZDZQYTV3TkU5d0lBZFJnWGlUc1NQcUVpVll2cCtJazU2Ly9DVkNDeGJYcVZF?=
 =?utf-8?B?Y0d1dytLNUpvNnIxd3N0dFkrcWQyb2NLRDNoejgyQmg2dVdnQVUrTXRMbWl4?=
 =?utf-8?B?N2JtRllNU0xBYU1rUm44VkhOS3p1Ukl3UVhpSlZ1RVhGZVVxM2NHbDdKcVhu?=
 =?utf-8?B?aS9RaStjTVZDWTQwNnRIeVVLeTF1VXk2eU9wNVBHa0lYcm5LeEQ4NjNVTDRG?=
 =?utf-8?B?NStxVW1lQ0lGNE16MFFObysrV3c5QS9uZWk3WWZYS29OLzdvaG53S2xPNTE0?=
 =?utf-8?B?WWZ6N2V0RTkyVW5zb0ExK2c0QU1rNTBFSkxlNC8rNEZBS1FzRmp4Umw1RXN1?=
 =?utf-8?B?ZENOTXJYZGJHeUtNVFZ1czNWdHlybHdkVVRzWUkzTFRkTk9CZmplNWpNZDVq?=
 =?utf-8?B?MU5qMUZqRzg0QisrRTgrQjZmUnVCdXA5Qjh6MUZSdWhtVVd2cFAvNjVTb0NE?=
 =?utf-8?B?czIzbDJFK0ltekk0VkZtQ0g1eFROTWdFTTFKUU5YRFNBZWxtVVl6SUdNM1Nx?=
 =?utf-8?B?b2srU1J0R3pHanMyN21UYUZNMmY3YWRWeGZPVHllVG5nOGJOUU0zRGdzU3NP?=
 =?utf-8?B?R0lZRjUxdkZJWlVOSnpMd21UenV5Yk5ZdlhYTCtEaEJReVkyVVMrZEVtZVV6?=
 =?utf-8?B?ZStVRUdlRHZBL0RYNC9kZDdrWUtQd1dubVNnT3dlU0JqVVh3bE1yc0s0NWts?=
 =?utf-8?B?SzQ5QVFCZDVkc0FXUXlxMkd6bVhEdi9JZGxaNnBIS3IrbGs4MEI3Ulg4UDdy?=
 =?utf-8?B?SEl0ZlpjZ3I0b3EvVHdrWTBPZndoOWV0TU9Xczh6cEdCRUVia2FRSGtmRmdY?=
 =?utf-8?B?cHMxTFZibTNINFpGMTkxeDdISUg2bnJ5dW9sQ3pmMWZMdHM3NUdyemFKSGJl?=
 =?utf-8?B?UEJXTDVydGF3cThVb2NJUzJvcXFLdXRkOVEvYzVHK1Q0Uld3MXFLTXVuQjEx?=
 =?utf-8?B?M2V3ejlJdGROaVIzcy8rcXJXU2hXTjNwTUcveTNFWE5NK3c1Mlp5UjNXNmlG?=
 =?utf-8?B?cXJZbWFrLzVuM1F4SUFJaFNwN2VmWmtjMTA1K0VNQmh0L1h6WnU1eGgrL1Bz?=
 =?utf-8?B?ZC9mRE9WVm5uV0RveFZMVnc0ZTB6dGkyWmpzS0NvZDBHalUzUzNxdzY1ZUJn?=
 =?utf-8?B?N1hYY3ZINWRKYXVtUENYRlFpWHlnSjF0WEthaVJneEVFV0JIT1dldFdtS1Nk?=
 =?utf-8?B?RnRKSWs1aWlJbXhZZ0kwZEpFa0Z1UTkxMXFPOU9kdWtqNW56WEZpR3ExV1dU?=
 =?utf-8?B?QU1yL2hsSjJRUVhrVS9ENXpCRkZXenFqTUJKSjA3TDdLYjJnZGNPZ1J2bnV1?=
 =?utf-8?B?SmhQN1NseGRBanhMREpBWXlGQ0JXR1Vta0NrcTdtbnFMTDVmS24xT2NyR0Nn?=
 =?utf-8?B?LzZVSDJIaVljSWJieDZPeFAzcVRQYk5ZalBuS00rMW15VGJyNWNjcURrdVhU?=
 =?utf-8?B?SEZaTzdwOC83UGRMb1pTbG9tcXNFTHhhb1ZvM1JKWDgrUjU4dXZ1QklDOW1u?=
 =?utf-8?B?WmdNYjlqbytXOUxZODZjT0h2N3laWXdOaGo4YjFMcm9BcjhNWTU0TWlGMFVy?=
 =?utf-8?B?ZHpJbGwwOFVGdC9iZkl5WlhQNXJuazNtMlF3b2lJUDFRR3NCZEJSaEdQbmY0?=
 =?utf-8?B?SXpkaWVZUW1PVnJGRE1RaUliYm1vSlp1U3owQXZMRXhpN0dlMXA0Ykh0WUll?=
 =?utf-8?B?dnVLVE50T3MxUlNEYVFOcUliQlpGcSs3cUV2YW9iWGJoWldKM0tONEo1MmNG?=
 =?utf-8?B?RjVuS05IR2ZsMFlKVnNoVC9xK25lNDRFZlpmS2RuSjFoQ0IyUkpOcndaaW41?=
 =?utf-8?B?VjZiaHJQWm5tZnJxd2JSSldSeFE4SjEraVhMSUZ3cHFDMEJmTHp1MGJEL2Uy?=
 =?utf-8?B?VGR1OHpCMWZkZndFMS9HaVkvK2tuTkRocW84dUt6UllRRU9IYVp6VmlnVExE?=
 =?utf-8?Q?+0tg0Tc8Vjm7F5GYp/TniYF6O6VnjuGjBOYPzim7PUaI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ceb2a5-928f-40a6-b80f-08db3a935946
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 13:47:53.7706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rs+K6dI2PqQ7DRh7+geaYymu2LCS6EX4C0WqYifXS9I80D3uW8VwRmuFzAmdPg9Ic7SZOG5BM3R8z4EL7zYubA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7993
Subject: Re: [virtio-dev] [PATCH 08/11] transport-pci: Introduce virtio
 extended capability



On 4/11/2023 3:00 AM, Michael S. Tsirkin wrote:

>> I meant, it depends on the capability semantics. Both PASID and legacy
>> MMIO don't need to be accessed by BIOS. We can't change legacy BIOS to
>> use legacy MMIO bars.
>>
>> Thanks
> 
> makes sense.
> 
> 
> now, imagine someone building a new device. if existing drivers are not
> a concern, it is possible to move capabilities all to extended space. is
> that possible while keeping the bios working?
> 
unlikely as bios is looking in the legacy section.

New capabilities like legacy (and pasid) has no backward compat 
requirement from bios and drivers.
so they can start from new.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

