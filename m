Return-Path: <virtio-dev-return-13505-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 501A8C001DB
	for <virtio-dev@archiver.kernel.org>; Thu, 10 Aug 2023 10:40:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 813411318D0
	for <virtio-dev@archiver.kernel.org>; Thu, 10 Aug 2023 10:40:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5D54A98655E
	for <virtio-dev@archiver.kernel.org>; Thu, 10 Aug 2023 10:40:41 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3FD5D9864C1; Thu, 10 Aug 2023 10:40:41 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2E8579864C2
	for <virtio-dev@lists.oasis-open.org>; Thu, 10 Aug 2023 10:40:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1691664038.697000
X-TM-MAIL-UUID: d8b5a892-3ed0-4feb-aa16-13cb6312ea8d
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KsKHC5fFWBSzpY07IkzAHw754e80dqRi7hKf3L3S4yCVWB7BlIw3rAlh3sVZkMIt2t+bhlKJOCLGSlDsnuNAsFXG2CMSfdyCldg6iGAjkhoTdufeBKMOkqo5iZQ53ycVGUJMkzK/a6h7x5g4TrRU3szDa0QjjIXAqcGS60TD1Zp9e66YK3AGKv3ZMdu6v2duPaWfzqFFmNEggx0vCTbtOFfgPgNJQXrXVxHe6jzPJSSgyazH0Rovsyjp3BlA+YZD5MuJz6BsZ0HpIKAxC6bZ6FHFwoJ1T24sMTPN6i0M+AqtVZ0uLke1GZf9K3p7SjE+CzomV88R7+WbE/YhjO0hZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejRTQm2vKFCc3dKsW1pLhwABm7xYdvndhQOtUPk8s1k=;
 b=RnbXVoF5KhEmzAmCT4J2uuvX1Sfh6ywE4DGIcRTvJQRwsMmCtbfmDrN9/htC9jYD05dNfczVSiLwwt6XH/znhhX6+5wza8b/IVg/qjlXEPLPJa6kuAwFW/waHElqY5vtdDePQxgZCf+X2rQ/VGEMh+1qc04v1snORHQjQ23e9LiR+5w4zmZDe+OrMg17488UFFHNdGexy3Fr3dJtLch/N+E0ws6q1dxHM4RazSq5KffWOov+WHs/V8uOJR7bZ5b/4mq1QZEheTtQvDQflaRJi3vH06ztGLy13+B4vfLA+Jx0T2dnXFJ5DETi88ZwIdxssYmHL8fo3p7a5Qs3D6JoIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <4374acf6-ecea-3a02-1058-42521beef0d7@opensynergy.com>
Date: Thu, 10 Aug 2023 12:40:35 +0200
Content-Language: en-US
To: Haixu Cui <quic_haixcui@quicinc.com>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>
Cc: "quic_ztu@quicinc.com" <quic_ztu@quicinc.com>,
 Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>
References: <20230417140353.870-1-quic_haixcui@quicinc.com>
 <20230417140353.870-3-quic_haixcui@quicinc.com>
 <ae8892c5-5eb2-72c9-9b74-cde7162094a2@opensynergy.com>
 <bca0df0a-2111-1f2f-69a9-3a2ea08fd37a@quicinc.com>
From: Harald Mommer <harald.mommer@opensynergy.com>
In-Reply-To: <bca0df0a-2111-1f2f-69a9-3a2ea08fd37a@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0184.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::16) To BE1P281MB3400.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:4a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB3400:EE_|BEXP281MB0167:EE_
X-MS-Office365-Filtering-Correlation-Id: 51a8c7e6-e035-459c-5e80-08db998e3b6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QVm5mqt74TcWm33IxB0OUbq3bCUsEVOi9/102p+mrGv+4FMizuwCH/0H7/l67sZvRE3SsjNw3VmM7IPCnGwzjq0lgZvr3mx/NYrtoNit2xcljtqaXuFjBreFlJDGZ1WiuH+nnw/AVJwT6PVfo20i/uKwRXMzzKjCm0UaF7d1FcIYudLO0QrwLDYBRNmJdPD5XhDk/Bg+Lc5h8zeDmNDJO/1PzB6sXOo4IwJFyDBbNLTRYK4RgPkOu7bGfSwWX7gsJYC7Yud0wRDrgagQwnYXpgxiIOGCQ/uckpacdDLycVk4HHKFhCc3SbyAFEPzM9AgyHBFLPNw/L0s6SbDfq5RwnDQWs9sDS7xU+5CvMSw93H5a1fqFgLyeiqxGbE516o5y5PNHilz3JlvRe1hd1NleR5sU4hb3tyzyCG9DkLS5AZq0LJUB6Bh1L1QBtYFChpRyaOVvSZpQ2aThEgGCP/qyHWfF+PsBCgsu7EW796lvKGExfqcn0DiAuY4n/yaeMja/KBgJK7JmWo4exnQzS5hTJ1jK8NKMxpTvT/0wWmFE0dEi8Yyy6mSbIfevwcK9dgG3eGHze+1Fz+lzV141LNNWJRWGFFMmbMLHe68ct14fQg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB3400.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(39840400004)(376002)(366004)(136003)(346002)(1800799006)(186006)(451199021)(2616005)(83380400001)(478600001)(26005)(31686004)(53546011)(107886003)(66476007)(66946007)(4326008)(8936002)(38100700002)(316002)(8676002)(41300700001)(42186006)(86362001)(2906002)(66556008)(31696002)(36756003)(54906003)(110136005)(44832011)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUZhRWdnRGlEMURTZ3d2UXdOM0lTY0xtblp0TndXNm9OOVdhbElwdFFpUUdw?=
 =?utf-8?B?Y0s0a0dzejRPeVJrbXBNOE5xZnovWlQrRWoxbmxRYXBnRCtueUVqTng1NS8y?=
 =?utf-8?B?THhWNXI4Q0tzK2VpSVpiWG1UYUE1OWsxNS9raER3ZndMUmx6T3VEbXYvMDNY?=
 =?utf-8?B?dG9jUlU0cnlLODZpbEsxYlU2WjZMWkFGQ3pYZmNsYlVGQjBHcW83Sk5pRlNM?=
 =?utf-8?B?ajdsdkxuSGVrTzZDQWRsUU9KKzg2c1BueHdGV1dvYjB1VlBJOExrRVBuUkQy?=
 =?utf-8?B?TlViK1Zud2hUNjhQTmVpQmlKNjhwTHJMcmFxLzBCenNGWjAvSnU4MjMzZzRE?=
 =?utf-8?B?dmQ4TXRZTDF3YlM0c0F5NjlTTU9IaEVxWEtNdWNBUzJ0VStpb0RYYlFZUEU4?=
 =?utf-8?B?dnBLSXdYUzh1KzFQK2diL1lCbWNUZHhTRXp6OUJKY3BpSm9oYXAvTktHK2Er?=
 =?utf-8?B?MHpQUURHODYvZkJOMCtaZjNscVRkSXZjdStCQmM5ejFiRm1RZUNoV3dseVV6?=
 =?utf-8?B?UzVURG1wVC8wM2xNOXljQUZKYjFXakRLdVFFdzJjTXphaEl1eFJMMTQyTDJC?=
 =?utf-8?B?WEpxb0lkcmxCMWZoeURueHlVNWh3djF2SkRrQzlLZWFtTk5MT1RYdVhZOUJX?=
 =?utf-8?B?bU43dURIWGdGeTNlN1NXMy8rRWEvYk9aSjQzRXdjWFdxUjVncHZmOXYrL2Zu?=
 =?utf-8?B?c054RVlwMUphQStsSXl3YkFEUVVjODNqdE1qNUFGMHpwR0g0ZmxjeGlxdHg1?=
 =?utf-8?B?YkY4U2ZPbDFLNlk2N2R0dzk4bnowVlV5cHYxdTlJVE16WHI3eHJSeEZmZjg3?=
 =?utf-8?B?dzJBQjFzM1FqZDk0dm1yL1E4U0gxai9sT1pEZ2pkNEJuR052Q2p5L1FQRmt6?=
 =?utf-8?B?WUNHclR3NWdrTVgyMkw1dzczbGJmTGtlWGFYZmswNElQeEUrUVRLVU54eDd2?=
 =?utf-8?B?OEZaWUhxRXdSdGIxYlRHcTYySW15QzRtZnlCMWxiaURjNkdQZzhKandjenFH?=
 =?utf-8?B?ZkJPTmZQSDQ4VkV2MkZvNU9NQVNmeFZYNVdpTUo2RUdvak1ob0syQjA1akpl?=
 =?utf-8?B?dTlzbmMyNFN4UHRVaFJCZ216YjVBVm5DNEtkUGgybTIrRjNVeDg2Vzc3Y2dW?=
 =?utf-8?B?eFNFWmlONU5adEpqSkoyM1k1aXNOVnI1aFJSd253N05kK3VBNnBaa0pHUERj?=
 =?utf-8?B?MDBOWWFJZ2JMYmgxT05ETkZXVkhMbWZscDFFUlFvK3hQSG9DNFhDYzM1d0VV?=
 =?utf-8?B?S1BOUFdjS3B5VmptQVN5MVBLcjRaYlAvYzlKUmhMK1RLWGtRWkVvQ0lCRHdx?=
 =?utf-8?B?N3ZkV2lvekRpd0FYN01aM2xpczJ3VVFRbEh2L0FuZnk2WkVzdWRORkVzUUZI?=
 =?utf-8?B?U3VLOHZuY21rcWJkUk1VWjJrbngvS1QvdlplSHRsaExXT3FFclA2Q2k2UVN6?=
 =?utf-8?B?ZHZlWm9FTVpYcWt5QUEzTXl6ZWNIbkRhSnIyUzRyejlMOE5IVkszdkRiTUVW?=
 =?utf-8?B?SDhjRnJSZU5tSUU0REhTaWhmdHp6TlFaT1ZzMTFVdDVmYmo0MXpXTTYzdVJ5?=
 =?utf-8?B?QXVNN05tb2g0c2o3dHArL2E2VVNITXRocU5EckswTUloNHYvY3RnODc2ekI5?=
 =?utf-8?B?MkJWdkZyeGZPWnFFZUN1VE1jVmJaaytRQjZpYTZoVXduSEIxQTIwZCswMXV1?=
 =?utf-8?B?Mlk0YkhtWi9mc1IzMVdjSDMrQ0JaSThOYkVQTDlvMFFLa0p6a3ZwRlZvekFr?=
 =?utf-8?B?Z2NZQ3JzSWQ3ZWpjRW9UdWRpNmR5bTkra2FrQzFGRExwazdZMm1Dd291emgw?=
 =?utf-8?B?UDlJOVNmVGd3U1h1bjBzSXl5OThVZkRsS3YxWVF0NVI4dkZlVFY5OGdhUTU1?=
 =?utf-8?B?NnFyc3crMzhzK1ZOYVovVVNGamI2YlhrT1ArckRxVitGTUJYUi9yV3E0UFBB?=
 =?utf-8?B?VWtmNXVtWTlVazluZy9hNXMxYjc3Zk9XUTRYTDNjWEVheWZ3YUFrR2x4OG9R?=
 =?utf-8?B?YUcxN3FpdmV1QmdyTVJCWllYakNSUjgyZURZOGI4dkNFV1N6aHd4L204cTgx?=
 =?utf-8?B?V3BmM2ZpOVY2b3RjR0ljb3pmRENNTFBLQnRMd1V4YVRIajRXVnVyVFNaTFUw?=
 =?utf-8?Q?rwck9xuK1GF6xtoHsvTVNpq/x?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a8c7e6-e035-459c-5e80-08db998e3b6f
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB3400.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 10:40:36.5907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rMDMu3zRfg7WqHCItrBKehBdG68/pqqMItZ8YuuE4dy6sd533j58MffEaxW2acGT8M4yvMlcC1YLkWg6zjTYhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEXP281MB0167
X-TM-AS-ERS: 104.47.11.170-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1011-27804.007
X-TMASE-Result: 10--18.869200-4.000000
X-TMASE-MatchedRID: cxtZ8fwm3r/5ETspAEX/non73EnA6dC3OTa4xErHZfccZzGOQm4bAzgs
	XzLh9833a+COKU1rx7L9jAPbJ6gzYbM1o604X4TM6x+Q+uPsJqq/Nbd6xg/gfsu5iPenOg5n9FF
	P2RWhMyALj8mIVUZiRZMVZVdnRK6PAk08qR8xiHhcB5L7DliBJXZOvzSQRphQ9UbnasvQBy2l4n
	BqJ8o9ae3KeBkXLe224gihFi6Zfb/GhEPYC3AekTtzE6tOwbpEwowsbJRkKznEnhxTskvEsfgA8
	WXCtbOVLwGpG9KGAnlTz8hewI1uSGdB5ud0RimKsNA365dJC+tE64d0xcPXxV3WG5Zj0johO7F1
	PDJFn7OfhPjuKqjYhL6B1htZXGdhHYWnx65yM4FSKsXuA7t++T+lO2MfrS2WrqTP0R25bxyn5XV
	NL66dGezVBDz3qLMER4SMHMVsPAggWR4x22YUzAGzyLo/JK0QX92WJTnL4z8ZigPOZWOMvfTRSq
	yCF4F8KPGwovj43tYE0n6PUuPyGayK4uYIquiJHiD2w0A4roa5dQLeftFg6V6PD+MQY5QMT0BRZ
	NI+YwbANog326X8vtXNOAQ2MSi2muMpo5XKw2858Sarp97J825FeHtsUoHu+201U7GTFxig3URE
	86Oc9eex3AHghqMoicH1wCrW3rFoBmTSwRxjXg==
X-TMASE-XGENCLOUD: e59e2b0f-448c-42a2-997b-2001e644faae-0-0-200-0
X-TM-Deliver-Signature: FE7252CADB6EF17353975437E501CF1A
X-TM-Addin-Auth: lYi7ETAh0fbEnGbhGfCC1/tQtRqyZ4u/+J1W0jMjXuq1jIauJIna7Qvc7BF
	FdBSB+4hW+/f4CP6/8VqaqOEMNDs9UW0gfIPwN4jaVT8Cbg7JCNSOHFgvQ69kF/MiS2Jg9lM/SB
	SQgOlJmohMSOxJT61A8ijkmPE1+4352F1PCRoEewSpDWan7OB5fE3Ws3i2ereNxepwGBy5/26at
	wHiMpoR3dDskIuovA3gATPlQqriKA15h/YT2EcTtU4pOWd7vNU1IpSFgsxOArqacHnqi3utTS9w
	S5P0brU14lR10/o=.wKjCJIAfX28uhoE/9fkmkOqvQCxEQCpdpibCr38WCqx5z74JFvaB4fHYVx
	b6gKLJGc7KY0G0DWqjWvKT27LPMgIH1F1HLUCsXt+8EL3OQ+r2kcolGkI5zRACL/HPhS7u/tKtB
	jHeZ3efS0qUSLVEjolloADeIjrhM02NGgeeCzlZXxZOzsBocOBrLAsjKABmV9IUuWNC1oEyTeTq
	FphGbmNhfh3bK1kM+V+0Ho2E9KToLvCH6rF3D94x+8LX5kXUzdj6y/VgtrGnlddsjPjHR5XPEC4
	mpfKzaxyqJtV63QO/iMK653QYQtaEcIDd9TMM54DRqaCA7JfJ3HXtKSBqYw==
X-TM-Addin-ProductCode: EMS
Subject: Re: [virtio-dev][PATCH 2/2] virtio-spi: add the device specification

Hello,

a quick incomplete on. I'm currently with both hands in an attempt to 
implement a virtio SPI device for our proprietary hypervisor based on 
the draft specification and your E-Mail. Means I see now some more 
things while implementing.

u32 len; /* @len: transfer length.*/

is this a byte or a word count?

The comment in Linux for the length field in struct spi_ioc_transfer is

/* @len: Length of tx and rx buffers, in bytes. */ so I assume this here 
is also a byte count.

As we have only one len I think it's still needed to look at the device 
readable and device writable descriptor sizes to decide on half duplex 
read, half duplex write or full duplex. Having still to do this the 
transfer length in the len field may be redundant (superfluous) 
information.

No problem with this, I'm now only at a point where I want to be sure 
whether this is meant as a byte length (vs. a word length).

Then there is no u32. There is le32. Only RPMB uses be32 but they have a 
special reason to do this. The byte order must be defined for 16 and 32 
bit values!

On 20.07.23 09:50, Haixu Cui wrote:
> Hi Harald Mommer,
>
>     Thank you so much for all your helpful advice and info!
>
>     I have updated the transfer request as follows:
>
>     struct spi_transfer_head {
>           u8 slave_id;
>           u8 bits_per_word;
>           u8 cs_change;
>           u8 tx_nbits;
>           u8 rx_nbits;
>           u8 reserved[3];
>           u32 len;
>           u32 mode;
>           u32 freq;
>           u32 word_delay_ns;
>           u32 cs_setup_ns;
>           u32 cs_delay_hold_ns;
>           u32 cs_change_delay_inactive_ns;
>     };
>
>     struct spi_transfer_end {
>           u8 result;
>     };
May become "struct spi_transfer_result result" for naming reasons with 
same content, see below. Just a proposal which may not be followed, see 
below.
>
>     struct virtio_spi_transfer_req {
>         struct spi_transfer_head head;
>         u8 rx_buf[];
>         u8 tx_buf[];
>         struct spi_end end;
Above this was "struct spi_transfer_end"
>
>     };
>
Device readable must go before device writable. So rx_buf[] and tx_buf[] 
still have to be swapped.

I need to separate struct virtio_spi_transfer_req in my C implementation to

struct virtio_spi_transfer_req_out { /* Device readable */
     struct spi_transfer_head head;
     u8 tx_buf[]; /* Variable array at the end of the structure, gcc is 
happy */
};

struct virtio_spi_transfer_req_in { /* Device writable */
     u8 rx_buf[];
     /* "struct spi_transfer_end result;" is behind rx_buf but variable 
array must be last element for gcc for reasons */
};

Means you have to calculate the address where the result code is to be 
written from some length information. Can be done. But then I should be 
sure about the address. And this I can only be after all the length 
information (head, device writable) are checked for consistency. Clumsy 
and asking for mistakes.

However what also could be done (but you may have to obey alignment 
requirement for rx_buf[] when words are transferred and may have to add 
some padding in "struct spi_transfer_result", I don't know this currently):

struct virtio_spi_transfer_req_in { /* Device writable */
     struct spi_transfer_result result; /* The result code is the 1st 
device writable byte */
     u8 rx_buf[];
};

With this definition there was no need to calculate the address of the 
result byte. Just a thought to make life easier.

> Also I add the member and field definition as follows:
>
>     @slave_id: chipselect index the SPI transfer used.
>
>     @bits_per_word: the number of bits in each SPI transfer word.
>
>     @cs_change: whether to deselect device after finishing this transfer
>         before starting the next transfer, 0 means cs keep asserted and
>         1 means cs deasserted then asserted again.
>
>     @tx_nbits: bus width for write transfer.
>         0,1: bus width is 1, also known as SINGLE
>         2  : bus width is 2, also known as DUAL
>         4  : bus width is 4, also known as QUAD
>         8  : bus width is 8, also known as OCTAL
>         other values are invalid.
>
>     @rx_nbits: bus width for read transfer.
>         0,1: bus width is 1, also known as SINGLE
>         2  : bus width is 2, also known as DUAL
>         4  : bus width is 4, also known as QUAD
>         8  : bus width is 8, also known as OCTAL
>         other values are invalid.
>
>     @reserved: for future use.
>
>     @len: transfer length.
Improve comment!
>
>     @mode: SPI transfer mode.
>         bit 0: CPHA, determines the timing (i.e. phase) of the data
>             bits relative to the clock pulses.For CPHA=0, the
>             "out" side changes the data on the trailing edge of the
>             preceding clock cycle, while the "in" side captures the data
>             on (or shortly after) the leading edge of the clock cycle.
>             For CPHA=1, the "out" side changes the data on the leading
>             edge of the current clock cycle, while the "in" side
>             captures the data on (or shortly after) the trailing edge of
>             the clock cycle.
>         bit 1: CPOL, determines the polarity of the clock. CPOL=0 is a
>             clock which idles at 0, and each cycle consists of a pulse
>             of 1. CPOL=1 is a clock which idles at 1, and each cycle
>             consists of a pulse of 0.
>         bit 2: CS_HIGH, if 1, chip select active high, else active low.
>         bit 3: LSB_FIRST, determines per-word bits-on-wire, if 0, MSB
>             first, else LSB first.
>         bit 4: LOOP, loopback mode.
>
>     @freq: the transfer speed in Hz.
>
>     @word_delay_ns: delay to be inserted between consecutive words of a
>         transfer, in ns unit.
>     @cs_setup_ns: delay to be introduced after CS is asserted, in ns
>         unit.
>     @cs_delay_hold_ns: delay to be introduced before CS is deasserted
>         for each transfer, in ns unit.
>     @cs_change_delay_inactive_ns: delay to be introduced after CS is
>         deasserted and before next asserted, in ns unit.
>
>
>     Could you please help review the transfer request above again to 
> check if the interface is clear and enough for back-end to perform SPI 
> transfers. Thank you again for your comments. 
I'm working and I'll come back on this.
> Best Regards
> Haixu Cui 

Regards
Harald Mommer



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

