Return-Path: <virtio-dev-return-13600-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2776FCA0FE4
	for <virtio-dev@archiver.kernel.org>; Fri,  1 Sep 2023 15:11:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6EAE42ACFE
	for <virtio-dev@archiver.kernel.org>; Fri,  1 Sep 2023 15:11:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6785B9865B8
	for <virtio-dev@archiver.kernel.org>; Fri,  1 Sep 2023 15:11:06 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5BEB098658E; Fri,  1 Sep 2023 15:11:06 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 43D21986593
	for <virtio-dev@lists.oasis-open.org>; Fri,  1 Sep 2023 15:11:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1693581059.857000
X-TM-MAIL-UUID: b864d096-d314-4a91-80a0-56d2657385d1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0eT5CUIeVtFDJnXoV2PZS+Lq4nXLF5l3InlJlYtMpSEX4xgzG5/XGQGIBqWoAH8VFd6d+10HaNIXVuCE218G59lKCxIxeMmpzELWNrl7JAy8VENe/6119fCfivrudQgkgKoONoVX3zOuBUozu02uKZSwFGFCIr5jxrQs00Z4gKiezFnkplYL8zAdQkeydEB2ATBWu7Is4lxu144FQrbIvDvaq8vBE4uLe3QKWHl6CVmil8rxMZTDfysLtc4bbuk2yn/dK6YI2KaSiDoLyigBnWybGT3N1SuaEMpuXSwGYXHmIp9KT+gzKNM4zbJt3njETQkpK/nic+15xAKPA/wrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARdt7H4Fg8JiO4O+lG5rbfyIvXuh7pDeHjeOwV7VbQQ=;
 b=aefK2EZfdTTcGaR+naMesrLWLWe+kZX6Wv/V9dvViDmjONy/WtVZrt2pRHsoj2ezuXRkoNw3yuFFDztbdg6INwj8ZJmOb1fe4P52HhW2TUl47jY8Ccb6PWlieCrHZkdsUOM+Ec29WyARAHGrl73nkxOMuUtvGusieXjV6oRHxmwTw56KT8EKgA4i2Z0psot2zT+7gNWN3LOclv+QwZcNkd0H+teWSDn3Y6Heerw5V1ksqbNeOqt7USWJjQiGV9NSZ7L3uaA1bIjNTZ3fGXQPLHpsI1HumlKuD8ENMzs8xvy306Me091DKJvdBgtujfFT60Bo61pcrLS+h+ynrKfJcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <88a72686-dae6-e72a-2e39-42388912a526@opensynergy.com>
Date: Fri, 1 Sep 2023 17:10:57 +0200
Content-Language: en-US
To: Haixu Cui <quic_haixcui@quicinc.com>, virtio-dev@lists.oasis-open.org,
 virtio-comment@lists.oasis-open.org, cohuck@redhat.com
Cc: quic_ztu@quicinc.com, jrreinhart@google.com
References: <20230901032933.32434-1-quic_haixcui@quicinc.com>
From: Harald Mommer <harald.mommer@opensynergy.com>
In-Reply-To: <20230901032933.32434-1-quic_haixcui@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE0P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::10) To BE1P281MB3400.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:4a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB3400:EE_|BE1P281MB1988:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d9d2b4f-1478-4b63-b5e7-08dbaafda587
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NffLGAq9uCLC4cT2KuUIFkvWyT45Nx98TOLlh8tGHBFighFZHzbZOmB7TPE0WhXOc/D8ZPK2aqdYiV2i/2+MVVfyiNWOLVTcJldb5RaealakiGRvYbmW8Q27EVrnhFwcDUpSXg7YmtFT9slhyInPjSDd3VWu7dBRJ3ms7exFlpbonw/pzp+F1erzGXHU8YeOoaz4GFyCOkqgPaTcXKNrpT8EZT7h2VCqjAYXsqlxZoeeSmM8/dacuuLYfkwqrxeQGQP0gwYWYDB+KbDMKnsP8DV1Oupuv51NpAr9L4zr4Tl95LWIRa7qv1zHU8RluNfyiq3nRTaW+Y2reoJXCuEWG+QetxEbkLXEEGncCT8AnxDk6UoG4cM5mqOXVs5bfa8VEUx2HZPBAvM/jg3O9oPnHy40xtDZWOw6E9NIsiI9F5kIN7QzaHTeQrtreTdhkYYMSWqcFamA8fHbvLXi11qNLGKtPsAy3rFVleZ3vaSw/G4F83i6hvZv0D/f7fx5P8VF1irUJV+Rl1ZpEsll5OuWYUft3UAJ3RUKPSEDwKJEiXut3ajegYisGfvAoGWLsZUYj83iJ6mFd9Nm50jjgAR/cOLKHdAi2Ru/l9YVKEi2Mww=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB3400.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39840400004)(366004)(451199024)(1800799009)(186009)(53546011)(478600001)(83380400001)(2616005)(26005)(2906002)(44832011)(66476007)(42186006)(316002)(41300700001)(66556008)(66946007)(5660300002)(4326008)(8676002)(8936002)(36756003)(86362001)(31696002)(38100700002)(31686004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ym85aWhJaUh3NlpKYWpyNmZIeGY0OGF6UmF3eE5OcHIwemVpcXEzYjE3QkFo?=
 =?utf-8?B?S212VkhHcnJnMnowbmRYcSt5Z2lPelJVa1BvaFhMOGZNakkzems4blZvdkxh?=
 =?utf-8?B?elZuSjNuK3pGaXRvaFVsODY4VjhVNzVZbldhU1NhMzl2Sk1qajdPTDZPRDhH?=
 =?utf-8?B?WlMxRk9lM0J5MCsrNmViRzNRd2lmRFBZN1J1a1dkZlA0RWZhc2gxMjlmWmtw?=
 =?utf-8?B?cUMra0dQNUlQNlZWbUZuRXo2YlFKb3BDWkRCU3VDdmQzTDlOdHpHVXpiakUv?=
 =?utf-8?B?NENWbnpwczNKNkZ6ZTNueitaZEtoWGN4Y2gvT1B5TlRBeE9JMlVPV0h6OCt4?=
 =?utf-8?B?OE41ZVZJT2FvMysvOEtPbkVWQ2QxQ2JlQ1Era1d1aloyWTNNMFRKWk5MRm1G?=
 =?utf-8?B?WFpZRW5zRk0xYm9UVmdQWFgxU0R4eHdUc2VZZDE1THBQS0Z2ZmRabTJZZ3l2?=
 =?utf-8?B?YkVCVmx1UTFWQXh2bXcreUk3TGljV1pYQUx1NmE1N1lrcTRBQzhYYmdDeC9i?=
 =?utf-8?B?M0NOV3BxK3k1MlFlQ1BhblVOSk9HM1R4eDE0djdleFBhby9IaUxoMEFvZnhp?=
 =?utf-8?B?UE1TZkdlbHBQeTJyeTRVTjFVVityTUFSNkRJQ3RSU21NQmpvSEh0U3ZZQ2Ev?=
 =?utf-8?B?ci9weXFxL2xjWUJaaXg1dnVLbDlXOVdGQjdEbmtkU3dqMEdGc3NhY3lZcStI?=
 =?utf-8?B?cjFtT0xuQncxU290UzlEUUdkQkl6SWF5YkdhNXVXSlB1ci9vTlpDWlc2bExm?=
 =?utf-8?B?b1Z3TGVRdGdmZTlGNlFLZ3J2Y08rY3ZQV1p3NStnKzdNcGJyb0VRT29EU2Qr?=
 =?utf-8?B?ZmNhd0lmbllTMGRpMlQ1azhMeUlXZGhYQkZWRFFISXp4VW9MR0NXeWk3Z2x5?=
 =?utf-8?B?SGMwK1c1cm5iaU81Q084bythZ3JrSWlCbENEWjNlNjB0VFNURTNDSWpSQXpo?=
 =?utf-8?B?cFdwNENtMXZ4SnFuaUxwR0hScVVqQXV3TDMrWXpXby9GS0hZRmM1cmFDYXdv?=
 =?utf-8?B?NWxrRVozUFNiSzNiaWVxVWxqaTN6L3J0SGZzSTV3bnk2TS9hTnRRZDVTNmtL?=
 =?utf-8?B?VUxDL0tMTmQ5NjhYVXhGTVZkWml0bElPRFUzbW1pTmNyTTNIK2tocXVOMTNW?=
 =?utf-8?B?VEJyVWM3S0N4alo3aDZqZy9makZ5ZUw1U3E0Y2tFa0pnL0VaK3MwUzdCdito?=
 =?utf-8?B?L2drK0RhNUVzVDdVbk5VdldwNWhWcDhqNlZaYURVWXV1ZE9FQVZhNk9hTEUx?=
 =?utf-8?B?RnZPMCtySytReS95K0ZvdmU5UHhMN3BHalpVSFdKODlKNGI4aTc2WFNxVHhD?=
 =?utf-8?B?U05EbXg0MytCY0hrR3ZNam9FYWlvTWhnK2tUOE1GWjdNQzIrNEtSWEF5Wkw2?=
 =?utf-8?B?RTBnZ0xjVkFLM1VLQ0hvTGhDZUNtay9ycDhlcThUalFVcjlwSEUrWS93VFgw?=
 =?utf-8?B?QVVyQ1Q0bUpHWGFUdXFkdG5mRGpZMVZPbDd1c2RXdGJtYkQvK20yTmFaYi9v?=
 =?utf-8?B?Um0wUnZxMFdNWVg1bkQvNTY5T2FNMGxMdnNSMDdabUhqTVVlMjl1dmxWZFN3?=
 =?utf-8?B?NnFjNXBJTWZvZkF4TS9lZGh4NTcwdmZPd0Y4emtDMldBVHNDL1pVV1hEeStH?=
 =?utf-8?B?cmd2bEVGUGsrTm0xUzgzYis1SitEakhYYmFlT0h6QjhoTWtJakgwZU93YlBZ?=
 =?utf-8?B?L2VkZFRMTTYxTmgydFptb0hZRmswWEo4dktUTzNvS05QOE9maTdSdTRqTzFs?=
 =?utf-8?B?bU0rMDF5RDhvTGo4UzdaOGlHdVhaR3dZbkp2akF3UUFxUEVmTHFvdHJ5VXg5?=
 =?utf-8?B?YkcydEZtV1ZjSUhtVmQ2N0Z1V0tsQ1lTTnNHc2ZBbndtMGNkU1dTemU3dDkx?=
 =?utf-8?B?Ym1lQnh4cjRWbEVOQ0puSGZncjRUSktEVGduUi9CbU8zSW5zemx6NThqVmhq?=
 =?utf-8?B?UnBQYzlMUHpwUnJtaDJmemNJc0oyMno2elJOWk5LTlJJYXdRTUtSUCtoZzNj?=
 =?utf-8?B?TGg2NzJiSlJQdnBvK0o2WWRuL2hoNHVxZnNTRkd4MUxhYWFxSVJjV1BEVUFQ?=
 =?utf-8?B?elQ4c3RNN0tKSmtrdHRsN21Sc3FOZ3Jidm5NTmw0bTJTc1hWSThtekFweHFY?=
 =?utf-8?Q?xAMkNyJOMlzAisNty0aTwWhSP?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d9d2b4f-1478-4b63-b5e7-08dbaafda587
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB3400.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 15:10:58.4913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Z/We6tgXN86LKDrugnrpOyaCJOWeKoK9YsSnNI7XFF9TfjGFBvN4AzLedKnxYeAiNy0JLnsBe2ihiFjtPSPVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB1988
X-TM-AS-ERS: 104.47.11.175-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1011-27850.000
X-TMASE-Result: 10--9.882700-4.000000
X-TMASE-MatchedRID: X4bcv0S75Kn5ETspAEX/non73EnA6dC3OTa4xErHZfcEo7RuIMv80Dgs
	XzLh9833ZcGkfeZP8vtLCgQieT3WXraZwakIWlZPS74sGh2G9bGU0D9syQiRTEUBeepgOyG6wmU
	T4MDCsQO9LLbMBWIxreIIoRYumX2/5BminDHFhmJzoxCmHXb7+r81t3rGD+B+OpqfTdGII65IYG
	Hn2wTZBFVEDPcaXSIM8lBojmamEexo8Behwsz8wcm2jIZUTQ3wB4BMfq4SzeI+0J9ZTAkB2Px6m
	KcE52cQw/N6Mv7o0jc1Rm+4VsXPJ32R47XZOqFn8kxNDHin3Z+OmNylh2VEB4vXantxmoFYkZZ+
	XOxo7izfXDU2ciEUMiRLwDK9TnZNmXejpL0l0EMk+VN5SeE/CqWtxA0qDTb0twg8nWmuAKrf7qT
	3sazIONaAIHU9wBaW414KcGUyzdQuenyXqLdFIn4f9vXTjfBbUW6JvL9bdLg=
X-TMASE-XGENCLOUD: 17878721-80c9-46a0-8977-78a5d4d6e8b6-0-0-200-0
X-TM-Deliver-Signature: 4948D745B22A34CF5C6013E2C378FAF1
X-TM-Addin-Auth: fo0Sh7Q2PVBrvLJBEJEj2i3EA0PnIQaKSVabVJZE6A8Cn2X3P4vqm4Y0XRU
	T8Mj6zVBNMK+AgGDhOunMKXc9rj7Aw9aMzgx5ZWspSoM7Yq7/TzwQ+k2zL7f6qwrYdicWiAedUP
	Fb9CJMWV6EsVj8hzAyuXc0cVAiyOBNlO+dGgoXYn7zwfFzVbRYl0b+6Ph3YGJMtx3s4NO1zIXl4
	fnPnSHsxoq/wny8r+tYCLPBB3HBagOB8czOs2gjqWP27GAjxJAJcrm794XDP74Ama8SxBWoOWkp
	KbyobhwXk8TCjM4=.vCtTqRmh14QS7ZvJFQs6W/Z2DSnxGDlC+CLOnx7aBhFWz5+X+Jl7hmQuIu
	NcYNjs5rvZgILIUbKG6/e9a1IESkojOYdh9wVsrUJNLiXGwBYObcNbAKcnyYkeQdnRPwLlNrcHT
	uADQJ2vqdjxp3VAvw7UqGTBlj01CMjCj9ZwkTsoeY3DwY78N7aFkPE6Q6JCbVShX93O/F1EO1XQ
	9mWiTlhWdnqVcah5zYes5MvYAyW7oyP8JaT3NRVRWses9pXMgZAtpuMlo0/GI7DErtW95Rmckdf
	r8nm6e/kv+ZcAPswr7+XQ+mfVzJ1kucoVDiod0KoTKtyfXmbCcmdO1b1fFQ==
X-TM-Addin-ProductCode: EMS
Subject: [virtio-dev] Re: [PATCH v3] virtio-spi: add the device specification

Hello,

I'm currently integrating your V3 update in our proprietary virtio SPI 
device and in our virtio SPI Linux driver.

The virtio SPI Linux driver is currently not yet in a shape to be shown 
and the paperwork with the company lawyer is not yet done.

Some short first remarks, I'll have to look again into the updated V3 
specification next week.

On 01.09.23 05:29, Haixu Cui wrote:
> +
> +\begin{lstlisting}
> +struct virtio_spi_transfer_head {
> +        u8 slave_id;
> +        u8 bits_per_word;
> +        u8 cs_change;
> +        u8 tx_nbits;
> +        u8 rx_nbits;
The "u8 reserved[3];" which was previously here must remain for 
alignment reasons. The "le32 mode" needs to be cleanly and visibly 
aligned to a 4 byte boundary.
> +        le32 mode;
> +        le32 freq;

Any hint what to do with the next 3 values in Linux? Currently on the 
device side I've a check that all values are zero. If this is not the case:

if ([any of those values is != zero]) {
         pr_warn_once("word_delay_ns, cs_setup_ns or cs_delay_hold_ns 
not supported\n");
         /* Pray that the SPI device can still cope with the timing */
}

No idea how to cope with those values using /dev/spidevXXXX.0 as backend 
device. Looked into some data sheets: If being not on Linux but on some 
small embedded controllers I would probably also have difficulties in 
some cases.

I guess printing a warning and hoping that the SPI device still can cope 
with the timing is the only thing which can be done in some 
environments. However having those values in the message is probably a 
good idea, this is not the point.

> +        le32 word_delay_ns;
> +        le32 cs_setup_ns;
> +        le32 cs_delay_hold_ns;
> +        le32 cs_change_delay_inactive_ns;
> +};
> +\end{lstlisting}
> +
> +\begin{lstlisting}
> +struct virtio_spi_transfer_result {
> +        u8 result;
> +};
> +\end{lstlisting}
> +
> +\begin{lstlisting}
> +struct virtio_spi_transfer_req {
> +        struct virtio_spi_transfer_head head;
> +        u8 tx_buf[];
> +        u8 rx_buf[];
> +        struct virtio_spi_transfer_result result;
Exactly the order which is needed. Having the result as last element 
there are no alignment problems with word sizes > 8 bits. My former 
proposal to move the result field to a different place was simply wrong. 
Perfect now.
> +};
> +\end{lstlisting}




---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

