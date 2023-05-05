Return-Path: <virtio-dev-return-12572-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6952DC77B75
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 12:28:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8A75823D56
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 12:28:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6D7599866BA
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 12:28:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 54F2798653E; Fri,  5 May 2023 12:28:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4185F98665C
	for <virtio-dev@lists.oasis-open.org>; Fri,  5 May 2023 12:28:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1683289685.928000
X-TM-MAIL-UUID: 88f34e91-1fcd-4f8f-a601-a9aab1995ad7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBDyF1XNYyihVQi3G7z3dJZAlDdx4JnrREx8PJ4UAknZ3dQptKZCAzxSvUtmOxcv0ZZ/rWLvkAtroB7XGFIiYe4m4o3MCvLYlJnQkXKehCGtpvF8BHlT3eDmmF8r0udKC74NpgM+GuAA5qb1dIHfFbbPhqYv1DUYksbD4sVJKsv37tsuJ4BOoFwgo7haGOKFrDNvnXUSPFb9snwFQ7TONQf2sQzxW4qkAQvnNN4bXwdWUUkX90DHhKz7Zql/BjRN+MvcMeW8aCSmAQolXwxnp7tFd929sIwEqiucq1MkcQL7iyupmdDyNHn8dzuBhOw3xf/5JUaT8XQ+NabGbjHE9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8IbMStNzfD+zxDUaD1g9zMIr8362onojGMDp+sU/xY=;
 b=nqHGa60/NvZiNiybWEEEbVN34U0Jelqd9xYQgPZFu56yOUqAmcD+Mr3ti2q/obCX+FtkvJrrQ5GYcUB8ivehrcbPtPWdK71MRmKivHW/Z28i3fte6RoicZlvGHPwdmLXy91coLQEjr/vn9m8oaaIGX1fq49FwpE5YWEGoReKXSyoHxGTAo3WOW7wJeaQXnRr38Rp4X1Cx6un5R9++QnhV9G/Ecd690B2THaNkD81/A5N8wd+OK+xNwpEnCRvCZASeqPxhCc4Z5Cgw32Wl8lS8RRWUxTxNJAZcMv311V2Oz00FFzT+d9RsS//239FfTFzq3ekSVLXqoqVzKm8aO7eoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <43d8df0c-fd19-c578-6a86-5d6a5cceb7b3@opensynergy.com>
Date: Fri, 5 May 2023 14:28:00 +0200
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>
Cc: Alexandre Courbot <acourbot@chromium.org>,
 virtio-dev@lists.oasis-open.org, Keiichi Watanabe <keiichiw@chromium.org>,
 Marcin Wojtas <mwojtas@google.com>, =?UTF-8?Q?Matti_M=c3=b6ll?=
 <Matti.Moell@opensynergy.com>,
 Andrew Gazizov <andrew.gazizov@opensynergy.com>,
 Enrico Granata <egranata@google.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Bart=c5=82omiej_Grzesik?= <bag@semihalf.com>,
 Tomasz Figa <tfiga@chromium.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 Albert Esteve <aesteve@redhat.com>
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <CAPBb6MVDKfKOyDFPiOL3fRp4Jn6WwMpSZt6V32EJ1CYW_+rw+w@mail.gmail.com>
 <909867c6-b66c-1281-45a7-38fd0aa32123@opensynergy.com>
 <87cz6mnaqk.fsf@redhat.com>
 <CAPBb6MWNfPH+e8=4zUcq2dV-59OdzTYSuN04Cg2rRPWao-nseQ@mail.gmail.com>
 <877cwttw2x.fsf@redhat.com> <87a60kg9rh.fsf@redhat.com>
 <CAPBb6MX+R-bDgJzracbZq6DE7B0WO=rtqS6GE1QDugdrFLryXw@mail.gmail.com>
 <877cvog030.fsf@redhat.com>
 <CAPBb6MWyVoEuXJoKvJhP-5zp-x5WrDwVWe8mxbXbCwyzfgqW1g@mail.gmail.com>
 <ca84a8f5-71ed-aea8-5751-60403d167283@opensynergy.com>
 <CAPBb6MUDWVK87_kGFen36tDJQoR-Les6djcKVihjuTKQBjweEQ@mail.gmail.com>
 <b5c9d69a-fbec-8046-225f-bdb5850bbd54@opensynergy.com>
 <CAPBb6MUFbZzTTPqztVXQpcPN+PtqrmCoyaD5dySYdP_7EbRDdQ@mail.gmail.com>
 <11372cda-a766-ef50-45d7-ed637b72a31c@opensynergy.com>
 <CAPBb6MVRPn6dM8ap9uDvX_ZHdHGvooq+LB7UGDaWBEuUtK3x=A@mail.gmail.com>
 <cbed366a-7f12-8642-18ef-350981279241@opensynergy.com>
 <87a5ylzf34.fsf@redhat.com> <87354dtp30.fsf@linaro.org>
From: Alexander Gordeev <alexander.gordeev@opensynergy.com>
In-Reply-To: <87354dtp30.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE0P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:a::18) To BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:4d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2663:EE_|FR0P281MB1660:EE_
X-MS-Office365-Filtering-Correlation-Id: dabfb6ca-bc88-43cb-80e3-08db4d642c47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	go0AGUjcNzBmK3WL9rZ8VlYztJsvoTGn6mw2NBJWwg5IijXxR1yq1YWgjYxMbi65rapyWq/t7s1vTdTrB9YJquc6TpOxdxTmhpLWDMxfnpp77Hsz3xMsGklfIDWz1QdCG35XnRhEu1OBBdz+UDdGc41Uvy6U1JDclkh7UJ5OLIts9Al3jgnSdpTU0agPC2PU/sa2oSdGYJ9fsevaU4RPoHLsWirblenyQZUJ3JG8tWbJoGih9V4TLB/2/5bFxKryqixAy/mT9fMp6zJlOxlXKbnmzN+8WqpTCHtyjGvc4LZW4kWnIjkfxHUWXdCeA5HoP1ovLhIN6UJSuX1y0g15CEtAx23SPEHKpl9FEqI2aQCM4D9gi9vA+6Pzt/q+zrCXugjnpOzPx/x4p+WBonEtYcdeUokNH0JUfs3eDWXWo+Q0I1GdjXW4nSR5e0VtHghFrgk7NozO1t7+VYF9y5FbIrUEylOmYqdoEY8mXXzt9tgqJYETgv81P/9hG0GxfamewaQ2rUhCJY76dfDHnJJ/lrnlsR6y8IVR+MyWhdPf3WU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(39840400004)(376002)(366004)(136003)(346002)(451199021)(31686004)(66899021)(66476007)(66946007)(66556008)(4326008)(478600001)(54906003)(42186006)(316002)(110136005)(31696002)(36756003)(86362001)(15974865002)(83380400001)(66574015)(26005)(2616005)(53546011)(8936002)(8676002)(5660300002)(7416002)(44832011)(2906002)(41300700001)(186003)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjMrT3ZkbmZodGJNR1E4SXBjQ29vLzFMQUZzNDhsTmE3WUlra0lkZ093bVFj?=
 =?utf-8?B?QjJTYUZERUJrZG9pWTVFWnhqQXQ1OHVwRVprR1gwSWk4KzNhVjBoWUhOcmkw?=
 =?utf-8?B?MnVvT3BNRTZZeU5Pbmd3U3V2U29FWXI3d3BpT29XbXgyWHhXK1NnVnRFVnJV?=
 =?utf-8?B?aitGeE0xV2RLMVFvbkhoZC94cTVEbll3RWorTW9LMC9EUEdiVGUreGt1T1hM?=
 =?utf-8?B?a3o4d0VCNU9iRitzNThKaWxiWVppT3ZmSHJYT0VKWFhaSkpCdlZudTdIeW5s?=
 =?utf-8?B?TEE4NXF3dW5jNFB5NTNONG9uQ1Rpd1NRd1BWdWRjTWxMRk1wUU9Mbkx2cmdZ?=
 =?utf-8?B?NGJVVUdwU1JTZE5sOTljb3hJWGYwMmtuMWVLOXVZL1E5ZW0zOEtLOWhYY0pJ?=
 =?utf-8?B?QUt4YTFRTTEwSFA2dUJvblhEbnVHMTZJU1ZGdjJXeTAraHpGbXIxNU5nRnJr?=
 =?utf-8?B?a2F4Qzhhd2pWTUNIS2VCRTBKcHhENTBmaGRHMUtxYUtHQjdNUk9Pc0pmYWlN?=
 =?utf-8?B?b0hoUEJsbE1SbW9FTG0wZVBuZmY1Sko0UFhNMEpqdXEwbGtQUldvRyt0WDRn?=
 =?utf-8?B?RmYvalY2SHFXOUc5RzNpOExBWWl2Q2RSZjJMQUwvc1hEZFZETDJBOTE5d1Yr?=
 =?utf-8?B?V2JOSlc4ZVZydFF0OXY5b0xpQWF4NGZCYTdWNlhlSnpFb09McFE3Mlp1d2ph?=
 =?utf-8?B?RDFmcUxRaEVwWkFHb1lXd29VbEk1S1Rrc2tXMEJVL3h1N2pKNDlIYUQ5RHA3?=
 =?utf-8?B?eHphdkJZeCtSMkpXeG1Vb3g3T0tMMW5NKzhOREtMTXJJRHViampvZkdVb2lR?=
 =?utf-8?B?RVpCUDlPOEFBS0FWNWo3T0pybTJvZGJpWXU2M0s5dXNVa2NmTzI2NlVyTmFD?=
 =?utf-8?B?YjlJZGk4SWF4TFdaQ2ZlaTFrZHhpMWdaZy9EbEJqY2RFZC8xTENMOXhWWllW?=
 =?utf-8?B?OElieVBZMXlHaTZuWHE1YlQ2VUcxRmhRNFFVV3VUUWJ5bTV5VHpPU24xdzBV?=
 =?utf-8?B?SDczMTdrdFV4YW54RDdXdzV6aHVGellTWWFRcWdnYzR2dFZMdjRESjlTd2pQ?=
 =?utf-8?B?bHU2NWJkZXdiWitrd3FFbm9UNHNLZGNtNVowZEFGaWVVaGZiWkViUExwai92?=
 =?utf-8?B?YWdQZDUvVEhFY3hjL2FwcWNjQm4rVjFWUWh6T3dEbE5hUmhWbUZXOW5WRENl?=
 =?utf-8?B?YXJyY3l0Z3RhU3BBQ3NoSHRCanNkaHg3Z0U1bDhXbld4TkNNSWNKMmtZYWVV?=
 =?utf-8?B?dXk5OSs1ajYwenRLT3M1cStXYVFXak92MGI0WU91SWM3K09sbWNKbFFtRkRo?=
 =?utf-8?B?Vm4rVzA3N0NQWXd2RkFBM3dKaVIzZ3JIeUl2ajFpWGNtOHQ4d1c5TmVBMTdV?=
 =?utf-8?B?K08vcWFOSzAzYkhqYnlIQytoQmE5aFJUY3A0Snc1NDgwRUJvdS9WV0FkV2hO?=
 =?utf-8?B?enYzVEtJYVU1Ny9CaUhKcVI2UnNqTVdncm8rckZ1Y2ZUNi9SZlVMTlFxc0JY?=
 =?utf-8?B?SmRLbGI1anFFbDFqd2xCUFdqclF2VVU0UmpZbUpZT2g1cWFjU3RrV1Y4WjNr?=
 =?utf-8?B?eHRkZDRvWS83VDh3S09vS2dPQ1FYNHNwNW9zUWNIRVVzaUFnL09nZzh2LzQ2?=
 =?utf-8?B?WU81ZzdSdHZqNXBIalVzR2ZCRHVlcXBKeVVQdHFidG10RmtJbmZ6Z285T3NN?=
 =?utf-8?B?VlRKaVF3SjZ6Q2gvNC9MSjVsSEtCWWNDM2t0RW1aR1dFTVI4RElEdENDQm1h?=
 =?utf-8?B?VnBnQWF2cWQ4UGZjdFB4R0VxdFZnQVpMZ2RQQXdEV2pqMG1IM2RZMlVORUJD?=
 =?utf-8?B?L1hOV3k0cTYvdHVrdFR6TVhwS2IyOVFSRGY2YTgrVkkvU04zM1pxK1BNWHZF?=
 =?utf-8?B?WFc4WFNsQUc4UktmamxOQy92L0ZMaGZXd0Mwanp2VzMxc0pYSjRFWDkvRjBR?=
 =?utf-8?B?S09OU1h0S2dvRDcwTmZiNElKTk9xY3pJY3FQcmhqLzIrZ2FIZndacUZYTDZB?=
 =?utf-8?B?cXFnemd6VzJ0ZlliMm9yeEk3MzlIN2tCTUN4ZWUvcjkrM3g1a0tyT2NYK1Aw?=
 =?utf-8?B?WmVHY2oyRzZBdUZQc3grRy94VmJ0bzYrNXBQRWo5ckN0MFhFR2puUjQzc0hC?=
 =?utf-8?Q?qT4s2wWaZM/+vKpZJIhaHQ4R2?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dabfb6ca-bc88-43cb-80e3-08db4d642c47
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 12:28:03.9394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ccozdQYgWHovWdAwc+rAF46dZy9aIeriFg/t3LzjzyrlVcE7opNlvDj9IpiYe01NFR7cjjNW+2usH5tiYQcwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB1660
X-TM-AS-ERS: 104.47.7.173-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1007-27606.007
X-TMASE-Result: 10--15.897700-4.000000
X-TMASE-MatchedRID: 8HTFlOrbAtH/9O/B1c/Qy6n9fPsu8s0a9mojSc/N3QeqvcIF1TcLYJF5
	C17m8KTraz4PPTQqgvbniA36f6y3d2C5k6NopKxYi95/KnWCU3TB0/7xhd4ByQmCgV9N+g/6Pkq
	rm3IbK/OEutUZt/fyv6Sb7sFeOcmT+UviL1yO5g1W1k0wh4Tk8cnlJe2gk8vIA9gN3JKb5fc+oo
	FgP42TR47uFu0kSjHibvc/LnF/WDNOBjuTIREKLd5x7RpGJf1aSP0QtOWCqNi15eNIExiead211
	7Mk9wKfuUxcEq68iwOP1k7a4QkoKCWHswFw/yu93J386TUJ4bxTZ+NmI28jKQRQRC1CtNtnQ6VP
	vO9yH3GgPyPjoZEIzQ9IHBj7BCrLuR7APGv5+oi/x8sBfQ/nQGCDsc7zPa02//6LNRWr/sZn9Ac
	gA9qVXkWG0od6ar2i0SFdaft8A7oSgRbp/xnTpEzs4u81P77pajzNTFMlQCOwuKAMD8Wm9VAkLg
	7xhHejhJtbBPDn7Juh78oNWbMU3xrqQlkzezhw/sUSFaCjTLwh0c5jiy2jH842FQxklqQfdmFLE
	8oqrHxMwzdkV3n2BPT4i5VfJY8BdfmnGfORa1eBDL96LgyuMd6FAdWmfaY5sHEoeZMrWPk/2z5u
	7TubFFVmKIFpfMZpXoWxuYEfxi8DYbPq8tS97PrNPkGWAHDfoQhLGoV/WBKs7MM97e6k4eCdtYO
	yAXl9u3mivaq19xrRssSdd19Bsqj7Jw6gjGGCbFnnYKyTEP74qCLIu0mtINf+k6ut5kUpOF1MgO
	Slvngo6z/XFe5Bmb0WWzFIXVmLV7lnn/Kaql9+yskgwrfsC30tCKdnhB581B0Hk1Q1KyLUZxEAl
	FPo846HM5rqDwqt1C3BEpDiD7/qKsl1kkKrfMTWlVl0itpxwzLvTZ4nwMz35Ces88kZHQ==
X-TMASE-XGENCLOUD: e99de108-7fa6-406c-b67c-9502cb3f9e3a-0-0-200-0
X-TM-Deliver-Signature: 1EA23BAD2FDFA614C316183D446021EC
X-TM-Addin-Auth: j7JvDzv1YUkiJmJgXyc7xiWmjXYE6bSpq2vChWemKJfWgLmxrfh+JnqFwqA
	DXmiDdKA6I8WR7rytEgCShi9A56mT3k7hbyubrfTvrVAHMeeQWymFjFIKM+f8XWXlMX+M3hwYP/
	bUbswZCj75i9VGRpJRDGtulDRPIqiOY6wwRyqDyDRZZvSVM4TkHpK5FeLY0xzYWzPrwAbm24IQw
	DUD9d8fdP0sTOc7YgZ3QLw6gp1BhGYP6ulgxcMZ0urjQJQ1rXPWtuyrKY+nnTVbzfdDH3ujO6kY
	lV5u+CoGKSV21x0=.OQFkzd2QrdHFEjbLtYcDPPgwawxuTWFQrSBJA3HgUKcTwgSZozLKHL4sbc
	GjwO8Pf49Xtn5xLWBdFwRwu+NqOPVGILpqjj5+54a6KjvlruUq5tgmzSkueJ29h3ve4kFQX6Qtq
	Qfl9IHVeh2vQD7KBASDd61RQVDEMw9/0brbSxS52lDSZ1TI8r1o3bc6idq4y43lRBSGscpRUAY8
	pHhM08ozLJntEq9cFoJhbyp4NFRwffWiZfGiqHb8EgLMp4Riluvfd9tvVmSeUbCd/1ZJIkfqRch
	uqsQufKoYLmdlrS061M40zQWe4YhROSJcnPJLJMzqCzVaqj70pvilDWEiJg==
X-TM-Addin-ProductCode: EMS
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification

On 03.05.23 17:11, Alex Benn=C3=A9e wrote:
>
> Cornelia Huck <cohuck@redhat.com> writes:
>
>> On Fri, Apr 28 2023, Alexander Gordeev <alexander.gordeev@opensynergy.co=
m> wrote:
>>
>>> On 27.04.23 15:16, Alexandre Courbot wrote:
>>>> But in any case, that's irrelevant to the guest-host interface, and I
>>>> think a big part of the disagreement stems from the misconception that
>>>> V4L2 absolutely needs to be used on either the guest or the host,
>>>> which is absolutely not the case.
>>>
>>> I understand this, of course. I'm arguing, that it is harder to
>>> implement it, get it straight and then maintain it over years. Also it
>>> brings limitations, that sometimes can be workarounded in the virtio
>>> spec, but this always comes at a cost of decreased readability and
>>> increased complexity. Overall it looks clearly as a downgrade compared
>>> to virtio-video for our use-case. And I believe it would be the same fo=
r
>>> every developer, that has to actually implement the spec, not just do
>>> the pass through. So if we think of V4L2 UAPI pass through as a
>>> compatibility device (which I believe it is), then it is fine to have
>>> both and keep improving the virtio-video, including taking the best
>>> ideas from the V4L2 and overall using it as a reference to make writing
>>> the driver simpler.
>>
>> Let me jump in here and ask another question:
>>
>> Imagine that, some years in the future, somebody wants to add a virtio
>> device for handling video encoding/decoding to their hypervisor.
>>
>> Option 1: There are different devices to chose from. How is the person
>> implementing this supposed to pick a device? They might have a narrow
>> use case, where it is clear which of the devices is the one that needs t=
o
>> be supported; but they also might have multiple, diverse use cases, and
>> end up needing to implement all of the devices.
>>
>> Option 2: There is one device with various optional features. The person
>> implementing this can start off with a certain subset of features
>> depending on their expected use cases, and add to it later, if needed;
>> but the upfront complexity might be too high for specialized use cases.
>>
>> Leaving concrete references to V4L2 out of the picture, we're currently
>> trying to decide whether our future will be more like Option 1 or Option
>> 2, with their respective trade-offs.
>>
>> I'm slightly biased towards Option 2; does it look feasible at all, or
>> am I missing something essential here? (I had the impression that some
>> previous confusion had been cleared up; apologies in advance if I'm
>> misrepresenting things.)
>>
>> I'd really love to see some kind of consensus for 1.3, if at all
>> possible :)
>
> I think feature discovery and extensibility is a key part of the VirtIO
> paradigm which is why I find the virtio-v4l approach limiting. By
> pegging the device to a Linux API we effectively limit the growth of the
> device specification to as fast as the Linux API changes. I'm not fully
> immersed in v4l but I don't think it is seeing any additional features
> developed for it and its limitations for camera are one of the reasons
> stuff is being pushed to userspace in solutions like libcamera:
>
>    How is libcamera different from V4L2?
>
>    We see libcamera as a continuation of V4L2. One that can more easily
>    handle the recent advances in hardware design. As embedded cameras hav=
e
>    developed, all of the complexity has been pushed on to the developers.
>    With libcamera, all of that complexity is simplified and a single mode=
l
>    is presented to application developers.
>
> That said its not totally our experience to have virtio devices act as
> simple pipes for some higher level protocol. The virtio-gpu spec says
> very little about the details of how 3D devices work and simply offers
> an opaque pipe to push a (potentially propriety) command stream to the
> back end. As far as I'm aware the proposals for Vulkan and Wayland
> device support doesn't even offer a feature bit but simply changes the
> graphics stream type in the command packets.

I'd like to note, that virtio-v4l2 is not going to be a simple pipe for
V4L2 UAPI already AFAIU, because it is going to have some patches for
the forwarded protocol in the virtio spec. AFAIK virtio-gpu doesn't do this=
.

> We could just offer a VIRTIO_VIDEO_F_V4L feature bit, document it as
> incompatible with other feature bits and make that the baseline
> implementation but it's not really in the spirit of what VirtIO is
> trying to achieve.

Thank you for your input!

--
Alexander Gordeev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

Phone: +49 30 60 98 54 0 - 88
Fax: +49 (30) 60 98 54 0 - 99
EMail: alexander.gordeev@opensynergy.com

www.opensynergy.com

Handelsregister/Commercial Registry: Amtsgericht Charlottenburg, HRB 108616=
B
Gesch=C3=A4ftsf=C3=BChrer/Managing Director: R=C3=A9gis Adjamah

Please mind our privacy notice<https://www.opensynergy.com/datenschutzerkla=
erung/privacy-notice-for-business-partners-pursuant-to-article-13-of-the-ge=
neral-data-protection-regulation-gdpr/> pursuant to Art. 13 GDPR. // Unsere=
 Hinweise zum Datenschutz gem. Art. 13 DSGVO finden Sie hier.<https://www.o=
pensynergy.com/de/datenschutzerklaerung/datenschutzhinweise-fuer-geschaefts=
partner-gem-art-13-dsgvo/>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

