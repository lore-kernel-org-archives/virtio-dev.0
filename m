Return-Path: <virtio-dev-return-12350-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A61EBC77B61
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 07:52:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BB5B526A2B
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 07:52:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9DB9D986385
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 07:52:11 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 88071986337; Mon, 24 Apr 2023 07:52:11 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 73C9198633A
	for <virtio-dev@lists.oasis-open.org>; Mon, 24 Apr 2023 07:52:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1682322723.514000
X-TM-MAIL-UUID: ed0f70d3-d617-4ac0-8ce8-c610caa9f059
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XinAQnqBWjdR9c8nkH0X3iglmb08vQTCUj4OiCPFe5SP7ut8sqNV476Qq98u/TLctwNR3u+awUlrBSQn6ilsF2wKSk+VcTpk9eG2YmrPqBBGpCTOm5IcvdYcPLBLiURxEe5pdXL0Q2Igh1JAkrqTXySDZcvqc3lo7eYeXe2jLTeqTL7Ck37VkeKKOQCk+Re8aAC+STQU5neRDy3mJ07OMdhXb4UA83K1IZLVNftQZjFMSO6sVlyF3sWDFVWeGagBhztSVmf5WBkmWi3K8OfzANcgxtnR2wBrnH7UQEMSAl8DVWvVam52HR3hMWtOAph+QMWyCC4BpoN5j4tR1MSlVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L46NbfwSduEyVlUfwLDe7cNcpWAMoZ6SdRyC08FCd6I=;
 b=mrQlZJNO3UFjJEy5OfLM+euzQSl46ecigaJdRYbLnDteR131URH/UaoODd5OcLJMPMETEImnSioI7/kq48EaGyITvy1UWTlG1GFzokBnCzOAiQGiVkPGy8wj7VP4KgNLL6NCGPbHTF+c5BeQLDdCToYWszotoak+AD+KlV6RyMLWKI7LT+sdDMH1GXPsQwjTgL8+jNfHFBxk8jq73fGn7rmZ6Z820KBoe3c9a9zaubqWHLJbcUMNPz9+5HPtJFhY3b6vHCkttVbn42DFkZLY9n9CuMRKtZTLKvvAGivJp3lwZucUwfsRvLxx0r9Z2w8YCMU5vt0UN85YiTsMN9I+Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Content-Type: multipart/alternative;
 boundary="------------H90StHKYugjae60XQcZZ7a0U"
Message-ID: <590378d1-83e0-b058-7eeb-2dbe5963670e@opensynergy.com>
Date: Mon, 24 Apr 2023 09:52:00 +0200
Content-Language: en-US
From: Alexander Gordeev <alexander.gordeev@opensynergy.com>
To: Alexandre Courbot <acourbot@chromium.org>
Cc: Cornelia Huck <cohuck@redhat.com>, virtio-dev@lists.oasis-open.org,
 Keiichi Watanabe <keiichiw@chromium.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
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
 <8ec36252-97c6-0378-e25b-fc972ea3a66d@opensynergy.com>
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
 <87o7nmk1rs.fsf@redhat.com>
 <96978ce8-0837-2e08-f5ca-66587807798b@opensynergy.com>
 <CAPBb6MUHXh0XYLH=8anWLNQaS+p6_VhMRki+qSqFQGeYQzBSSA@mail.gmail.com>
 <2d5df33a-c246-81ee-92e7-a44712600e62@opensynergy.com>
In-Reply-To: <2d5df33a-c246-81ee-92e7-a44712600e62@opensynergy.com>
X-ClientProxiedBy: BE1P281CA0326.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:87::17) To BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:4d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2663:EE_|BE1P281MB2853:EE_
X-MS-Office365-Filtering-Correlation-Id: 760440ad-5e6b-4869-8e0a-08db4498c9b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oIB4/nuls0JoFROqgFyx4nH8E8ywUi+hINWlGc8OeBz2+bgFShY/pi+Ivg9E50Cvg6c7Q2M78diSjRSHY0JdS+TX29RleG9HhevvX+YXleyvM/oOAQ8upUJ3uRdVheVzGuPFabXjGrx+q4uJbcXiCMLfTIssC2cUL6+TdwxRiZk65TGqQzHesW22CxcpOzBX42umAb3INV1OEJ8xgUJS/G4iERdubub6WKPtkGsgE4ynvKy6PHBTM0UhVc+cECAybCWtc7V/uN/T/kO6cpq6iqlKLUuvcpSNRhrRbNmpHE+hIHj8wJGHwNYBVi0p9avO5XYDy9tP8kKciH2IdyMhwDuO0f6vKP3fujXkgf8LBi96aQM0LfYBdQ2JcuTLU8KAWBezlopKNw44ShSwROrVmYyJdTCvADUbEseMauxXVsFeHzUzrvrhxxAASbEgoonxwtb8mJ37txCCbyBBrlhwWHJ09+V5FKXAaCkvX0vQ61u6WxvyWGLIIAOJeVPmZmXo5FvZg995kp+mdzOeg91auqmK81tLic7b0WrYI97uaBo/04GMXFHgGMKRhdiayRW12ZHKdbWbRxwfWnsRCqpmzSYrKI5SO3RwvX5IHAIRx8w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(346002)(39830400003)(396003)(451199021)(30864003)(2906002)(66476007)(66556008)(66946007)(6916009)(316002)(4326008)(44832011)(21615005)(7416002)(66899021)(8676002)(8936002)(5660300002)(41300700001)(15974865002)(36756003)(31696002)(86362001)(26005)(186003)(53546011)(38100700002)(478600001)(33964004)(966005)(66574015)(83380400001)(31686004)(2616005)(5930299015)(54906003)(42186006)(166002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmdLVWxqOElUR2o0VU1aTVV2ZmNJdEp1Ujg0L3RCRmxZeW10SnltWEV3TWFm?=
 =?utf-8?B?ZnB3RWsveUtJV2MzbkgxLy8rVU5HZ0VHc25SK3pUb1FPaDZ0eEwyb3JmcXF5?=
 =?utf-8?B?RS94bUVIY1o2L3ROcTNCOFZOczhtVWk0RjF2UWRxdDh3UE9wUlBjUDlLS3Ez?=
 =?utf-8?B?U0tjc2c4Y0pac01TcDJTdEgxZUN3cW1HV3RIZTc5ZFdnSDdjMmRucXU4dkU0?=
 =?utf-8?B?aXhidEkxdFQ0eXpNWG9DT1dRZnh0Ujd1ZWwwZWpWMDF3QnAySWMrOVJkQ05T?=
 =?utf-8?B?K0c2dUdqY1R6OE5WTzZxcUlXNk1VbUgrNkNEem8relQ5RXM4ZTFNOUR4NUlk?=
 =?utf-8?B?Z0NYa00zcm91c0xYbEhtZmxnWTV2NnVvamhLTzlIR1FQYmNvZ0wrd1RzRWRO?=
 =?utf-8?B?aU0zSlRzWmpYeDFhTUZZVXRpNjRIMFdZamRUa3VjUlhjTW9LeCtkczlRc2Jk?=
 =?utf-8?B?V1R2VzBQYis5K1NHWmNpYXQwYkJFcG03a3NyZ2JFcHZaMG5QUjIwTFowWGxQ?=
 =?utf-8?B?UytUUXRLVVYremF2eEJucjJ4YWpyY0t0K0J6Mkkzb1FxWmtvSWVJczQ2d1dF?=
 =?utf-8?B?SlNJRGRvQ2dCSjg3alY2ZlZCL0JaeUJranlBTUQxRGwzK25USTZoVzZJK2pE?=
 =?utf-8?B?WGhTcC8yVHZpdUZLMldvNnl3MEs0MldIVGExN2htZVRGK0RJWTNIcUUzczA0?=
 =?utf-8?B?MU9yYWNiZmJqVWhYRUc5QllYMGFJZGIyY2wraEtGZmg5RDVuYTkrN200czFJ?=
 =?utf-8?B?Q0tyU05qZTRCOWNRNUpPbE9jbkpUSE9vTkpFeUk3NU51ci9TamdidzhIWFov?=
 =?utf-8?B?cHZZMTRMdTBFS1BSYlVxZ0tGTkkzYmk0Y1N1b2F1TnBpUVVHMDZ6RHo3ZXl5?=
 =?utf-8?B?QUpIY2tTZld5Z3A1NGtmai9IZVZWZEtkZUlMcGh6eVlNZkgzLzZkeHlyelJx?=
 =?utf-8?B?YWlMMm9MU1kvcUk2SXRvUW1QeWM5NCtyb3oydjMxS1plK0cwMFZvVC9Ub0FB?=
 =?utf-8?B?RzJkczNLaHNMYnJnWll4MDA2SDVWVEdIdDFZZ2Y5OUswVVI2QWN1RmdCZ2Fj?=
 =?utf-8?B?OFpqWXlUQ0htOTkxN1pYbGgrZWJQTUZhRFZpVE9XdlNpYUpGSnRPclFYaXAx?=
 =?utf-8?B?dmNDK3NEUm9pTGpVWE5Lc2IzMUlnSHpURk8zM053dDJ0Z0ZOZytJbDVYRkEw?=
 =?utf-8?B?SHNUVTZpZzFLUmR5QldpbGhSTjNiKzdHOWcrMjlQQ2p1aGFvQzdKdUNmN2tX?=
 =?utf-8?B?eGtCMDI4Z0hveGN5SVUzdXI0eFlXQjFNOHBwZTFMOURqRXRBM0pvRS81MVRx?=
 =?utf-8?B?RThlUFp6bFd3MkZyeDlXaGlCZ2hQbXpQUVE0K1VuQjVpVGlyalExcWhpVVJo?=
 =?utf-8?B?VTdMTDFMZVVBV043dm1yOFJJVjFSNFVPZVRidkdrL3B1d2I4QThtSGpvVDFY?=
 =?utf-8?B?b0NWMFBUR3NPak5FOG92cmxpUFVUQ2FjbWgrcmVQVXhKemFEY3BMajE0NWJo?=
 =?utf-8?B?cThDcGRzMDVHck5Ec1JqMzdrV0pVKzlyQU10WGxFNDJNR0xNSmFsQ1Fqa1cy?=
 =?utf-8?B?aVR0T0dOanVoRGxlNjFvcjMvckhGT0oyQnBIQTJTc0VySnNnRG83Vkxpbjht?=
 =?utf-8?B?d3hyOGNGd0xlRHF5NFpJY0JlQkd5SUlrMGdWQThLR0hkZ2F0cGZ3THhtS0Vt?=
 =?utf-8?B?aTJmanNTQVFkak1sVno1VysvQ1hVQkpsZVIwdXVOa2MxSFE3Z3ltQldSbDM1?=
 =?utf-8?B?cGhMcGdPSU03ZlZJMmlISWpvT0ZBZkplaHpBQ1hCR0VwOFI3V2M2US8wVFNB?=
 =?utf-8?B?VmZVUURPN1hmdmt5VW1oRFlEZTlkcFJZU2FxK1VjSGh1ZzV1Zyt2dSsvLzMv?=
 =?utf-8?B?cHhSTXE3TkVzV1lMdDcwWHRLcGd6RXk3WElCZGR1Q2lIakhqWlNZNTdhV2ls?=
 =?utf-8?B?azZ4Q1kwc2Zyb1lublIyemhQMmxWYi9IYVhuOHJlbmpVU21mZ1o3UnZzYWVE?=
 =?utf-8?B?RjVocGZ0UUxUbXZJKzdJaXNnUnVEYmd1RzZLSFl5U2d2YXluVkc5Q0Y5K1hZ?=
 =?utf-8?B?SmZwMGp1enRhVldNM2pRQ243eDdEaWYyM240MVRoRG9wYjI0bzZ2cmtPK2d5?=
 =?utf-8?Q?TZNq81M51mG7nm5oso3h7ZFk+?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 760440ad-5e6b-4869-8e0a-08db4498c9b7
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 07:52:01.4416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J13rLMAApKgzaZbuBFofoiUUfhmFqzcl6FWIlSXdQqXuz0KJD5fU3sqwdfjs/cKVnx7w6VZTfCEGs0O+JJKVgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2853
X-TM-AS-ERS: 104.47.11.172-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1007-27584.005
X-TMASE-Result: 10--37.241200-4.000000
X-TMASE-MatchedRID: Z/tjqhsgM6c7iuZ/mdYYtp/OvRv5zwoz66/RLIXrqr5Nsk6futQ8rfMW
	54P2B2tdZW/urdIQGaA3Gqvmq0YYlKxAhf/GPomf3ymqV5Ai0QV1ie3bykuWZLcsG6QZ39qZerG
	HRd1u3jC8yXEu2oDUmQvBTB90+he+mGrGwE7uWss8VenKTIjbG5/bumQx78u3hI7uvji8nivW+7
	itRinqk275C+jYgiFI3IFFT9wqfr3ataep3h++VCwsBv7M8bI1yPaqxrNNVliwSv605Vb5pPR6u
	jyZrvNs4bVbyN6yIMmdVNZaI2n6//SzAdIVxUno1nkLa3J3C3002W+8wkuE6x9WA9NI1E2e57N+
	ORd86N/IW5a7efE77bU+IyHhkXf1twpUiv21DA2tI+DimHQ4ghCz9g14hIMa16YOozJj1NDqR0z
	tm0W62JdW3P+FD/5OueYB1mSXzr+W0X7Fb7OFSJ+9KccEt4Mqol+A+a939c7Q5qxD9sQ94w+wyJ
	IhO/VV9yyimb6mLJSVOwZbcOalSwD4keG7QhHmTmg3Ze6YIL3h06w0q6p9rDBM89zfz0RAuyhi1
	qdMR2KoGSK7rXzPTUz7FUUjXG1jTSz0JdEAJbRzclWiNnbt2NCXQ+yABwj7LKXHcHPDLMfBxdVW
	hHsRSFLRt36Lwnl5EVuC0eNRYvIEx2nnXvzNI5qs+XWbwitjrCkK8qAptV9RW9Ed/8S305q+1ef
	JrI1/2DJQA8IHlR3ZJrfdkZdZ1so/cAb3yVoWF2J2qC/34DuQI8wbOqahex8Yexx41To7GVfpkK
	qAaSuzj+3e9BXC/a2KjXrPLU9heom1eNAcnz6bKItl61J/yZUdXE/WGn0FxbYCTleOUf6/ZOFeD
	eXHgFIZuIPZ7iVn9bHsNi62RRvmFtt/5bvnJdge0ifMc9Yj3D/Bvd13U5a/03aXrkermJKLQn9o
	hRavSBJ3Kmz+Vp0=
X-TMASE-XGENCLOUD: NULL-NULL-5-0-1
X-TM-Deliver-Signature: A95E327D7DE3E4A00DF8A2A63B927F4B
X-TM-Addin-Auth: C5ib8CPjk8cqeoZwK4dupUV+au7LogtCazIJcnPYrhdfKmnaWpXNB0wk9a7
	p36lqfSiK0dY/7jtDWDqU2TpffvIqnoy3jQKXa112CLQXZlZKXP3twQLX49q+MLN/NrMwNPIBw3
	Hj7WpiD/EJAws7eXOKGMkNER4uLeNdfjd4lgP/+nIl7KLTC2P30DELVUtin0ulaYtgcyNdz2p1u
	9QymKTFUIulkFyRuqaujxqcEgTuRK7+0l/kiLyci/BGhuEls/Pem3Oavrq+7XGcUhe6m5fLbzOo
	m1Pv/EzRe+p+V1w=.FTd6kb7A6rLBxU1QkusaaDJu/nLSGK7s9E/F9GIkkL4yDYGis9j7AESA3l
	aAIsjbUaWNUxLegvbKR6uOhUkmjWapM6Rq8fkbzVynKE+OmB4SZIHiXJW/vvotlfLuJ+S64AH9y
	7XKHVfdiTeF1Kbhzfz4Zcm1qNWbEUyne3HST2nLLRu5OINgKvAJNS3xiGS4CDNL/U5y299Nq9ri
	X13X7kq5dj6B95cnokOHyai6QSlB5KVxxUraHmrnmloImWk0hsNKe9O2V5/m/EywMWz9ertthJx
	gRNGSzcsn6LczeHe5NIHJgh+2pWUDwTAVCt2mnrsn5UECDX8vFz2Yo9eHvA==
X-TM-Addin-ProductCode: EMS
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification

--------------H90StHKYugjae60XQcZZ7a0U
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 21.04.23 18:01, Alexander Gordeev wrote:
Hi Alexandre,

On 21.04.23 06:02, Alexandre Courbot wrote:
* I am still not convinced that V4L2 is lacking from a security
perspective. It would take just one valid example to change my mind
(and no, the way the queues are named is not valid). And btw, if it
really introduces security issues, then this makes it invalid for
inclusion in virtio entirely, just not OpSy's hypervisor.

I'd like to start with this and then answer everything else later.

Let's compare VIRTIO_VIDEO_CMD_RESOURCE_QUEUE with
VIDIOC_QBUF+VIDIOC_DQBUF. Including the parameters, of course. First,
let's compare the word count to get a very rough estimate of complexity.
I counted 585 words for VIRTIO_VIDEO_CMD_RESOURCE_QUEUE, including the
parameters. VIDIOC_QBUF+VIDIOC_DQBUF are defined together and take 1206
words, they both use struct v4l2_buffer as a parameter. The struct takes
2716 words to be described. So the whole thing takes 3922 words. This is
6.7 times more, than VIRTIO_VIDEO_CMD_RESOURCE_QUEUE. If we check the
definitions of the structs, it is also very obvious, that V4L2 UAPI is
almost like an order of magnitude more complex.


I think, it is best to add all the steps necessary to reproduce my calculat=
ions just in case.

VIRTIO_VIDEO_CMD_RESOURCE_QUEUE is doing essentially the same thing as VIDI=
OC_QBUF+VIDIOC_DQBUF, so we're comparing apples to apples (if we don't forg=
et to compare their parameters too).

To get the word count for the VIRTIO_VIDEO_CMD_RESOURCE_QUEUE I opened the =
rendered PDF of video section only from the first email in this thread. Her=
e is the link: https://drive.google.com/file/d/1Sm6LSqvKqQiwYmDE9BXZ0po3XTK=
nKYlD/view?usp=3Dsharing . Then I scrolled to page 11 and copied everything=
 related a text file. This is around two pages in the PDF. Then I removed p=
age numbers from the copied text and used 'wc -w' to count words.

To get the word count for VIDIOC_QBUF+VIDIOC_DQBUF I opened this link: http=
s://docs.kernel.org/userspace-api/media/v4l/vidioc-qbuf.html . Then I selec=
ted all the text except table of contents and did followed the same procedu=
re.

To get the word count for struct v4l2_buffer and other types, that are refe=
renced from it, I opened this link: https://docs.kernel.org/userspace-api/m=
edia/v4l/buffer.html#struct-v4l2-buffer . Then I selected all the text exce=
pt the table of contents and the text above struct v4l2_buffer definition. =
The rest is the same.

Also it's quite obvious if you look at them how much bigger struct v4l2_buf=
fer (including the referenced types) is compared to struct virtio_video_res=
ource_queue.

Do we agree now, that V4L2 UAPI is not only marginally more complex?


Also please read:

https://medium.com/starting-up-security/evidence-of-absence-8148958da092


This reference probably needs a clarification. You argued, that V4L2 has a =
good track record so far. Here is the quote:

FWIW V4L2 has been in use for a looong time (including in Chromebooks
that do secure playback) and I am not aware of fundamental security
issues with it.

But absence of found major security issues doesn't tell us much about the n=
umber of not found ones. Absence of evidence is not an evidence of absence.=
 At the link above a former Director of Security at Facebook shares his tho=
ughts about what could be a good evidence of absence of major security prob=
lems.

So a bug bounty program with high premiums that covers V4L2 would be a bett=
er argument in favor of *already written code* in my opinion. Not for new c=
ode. Also probably it is also an argument in favor of the spec, that is the=
 V4L2 UAPI. Like that it is polished enough. Not so sure about that though.

There actually are several bug bounty programs, that cover the kernel. Thes=
e are Google's kctf, ZDI's pwn2own, and zerodium AFAIK. However the premium=
s are not even close to the ones mentioned in my reference. Anyway this mea=
ns, that using *the existing V4L2 code in the kernel* is probably OK. But t=
his creates some limitations if we want the actual code to still be covered=
 with these bug bounties, right? This means, that the host OS has to be Lin=
ux and the actual hardware has to be exposed through a stable V4L2 driver, =
that is in mainline for some time, and there has to be no or little process=
ing on top. For us this is not possible unfortunately. In the end both thin=
gs could be secure:

1. V4L2 pass through can be secure because of the bug bounty programs and a=
 lot of attention to the kernel in general.
2. For the new code this doesn't work, so the spec should be as simple and =
device-centric as possible. Because, all other things being equal, there ar=
e fewer errors in simpler programs. So defining a subset of V4L2 UAPI inclu=
ding the data types looks like a good idea to me. The stateful decoder inte=
rface, that you point to, does not define a subset in the data types.

This is basically my reasoning.

Also these two specs don't need to compete with each other. They have diffe=
rent limitations and they are for different audiences. If you check the XKC=
D's comic, it is about competing standards.


https://www.schneier.com/essays/archives/1999/11/a_plea_for_simplicit.html


A quote from this article:

The worst enemy of security is complexity.

I hope I've provided above some evidence, that V4L2 UAPI is significantly m=
ore complex. You asked for one example, I provided it. For us this is alrea=
dy something to care about.


--
Alexander Gordeev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

Phone: +49 30 60 98 54 0 - 88
Fax: +49 (30) 60 98 54 0 - 99
EMail: alexander.gordeev@opensynergy.com<mailto:alexander.gordeev@opensyner=
gy.com>

www.opensynergy.com<http://www.opensynergy.com>

Handelsregister/Commercial Registry: Amtsgericht Charlottenburg, HRB 108616=
B
Gesch=C3=A4ftsf=C3=BChrer/Managing Director: R=C3=A9gis Adjamah

Please mind our privacy notice<https://www.opensynergy.com/datenschutzerkla=
erung/privacy-notice-for-business-partners-pursuant-to-article-13-of-the-ge=
neral-data-protection-regulation-gdpr/> pursuant to Art. 13 GDPR. // Unsere=
 Hinweise zum Datenschutz gem. Art. 13 DSGVO finden Sie hier.<https://www.o=
pensynergy.com/de/datenschutzerklaerung/datenschutzhinweise-fuer-geschaefts=
partner-gem-art-13-dsgvo/>

--------------H90StHKYugjae60XQcZZ7a0U
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
</head>
<body>
<div class=3D"moz-cite-prefix">On 21.04.23 18:01, Alexander Gordeev wrote:<=
br>
</div>
<blockquote type=3D"cite" cite=3D"mid:2d5df33a-c246-81ee-92e7-a44712600e62@=
opensynergy.com">
Hi Alexandre, <br>
<br>
On 21.04.23 06:02, Alexandre Courbot wrote: <br>
<blockquote type=3D"cite">* I am still not convinced that V4L2 is lacking f=
rom a security
<br>
perspective. It would take just one valid example to change my mind <br>
(and no, the way the queues are named is not valid). And btw, if it <br>
really introduces security issues, then this makes it invalid for <br>
inclusion in virtio entirely, just not OpSy's hypervisor. <br>
</blockquote>
<br>
I'd like to start with this and then answer everything else later. <br>
<br>
Let's compare VIRTIO_VIDEO_CMD_RESOURCE_QUEUE with <br>
VIDIOC_QBUF+VIDIOC_DQBUF. Including the parameters, of course. First, <br>
let's compare the word count to get a very rough estimate of complexity. <b=
r>
I counted 585 words for VIRTIO_VIDEO_CMD_RESOURCE_QUEUE, including the <br>
parameters. VIDIOC_QBUF+VIDIOC_DQBUF are defined together and take 1206 <br=
>
words, they both use struct v4l2_buffer as a parameter. The struct takes <b=
r>
2716 words to be described. So the whole thing takes 3922 words. This is <b=
r>
6.7 times more, than VIRTIO_VIDEO_CMD_RESOURCE_QUEUE. If we check the <br>
definitions of the structs, it is also very obvious, that V4L2 UAPI is <br>
almost like an order of magnitude more complex. <br>
</blockquote>
<p><br>
</p>
<p>I think, it is best to add all the steps necessary to reproduce my calcu=
lations just in case.</p>
<p>VIRTIO_VIDEO_CMD_RESOURCE_QUEUE is doing essentially the same thing as V=
IDIOC_QBUF+VIDIOC_DQBUF, so we're comparing apples to apples (if we don't f=
orget to compare their parameters too).</p>
<p>To get the word count for the VIRTIO_VIDEO_CMD_RESOURCE_QUEUE I opened t=
he rendered PDF of video section only from the first email in this thread. =
Here is the link:
<a class=3D"moz-txt-link-freetext" href=3D"https://drive.google.com/file/d/=
1Sm6LSqvKqQiwYmDE9BXZ0po3XTKnKYlD/view?usp=3Dsharing">
https://drive.google.com/file/d/1Sm6LSqvKqQiwYmDE9BXZ0po3XTKnKYlD/view?usp=
=3Dsharing</a> . Then I scrolled to page 11 and copied everything related a=
 text file. This is around two pages in the PDF. Then I removed page number=
s from the copied text and used 'wc
 -w' to count words.</p>
<p>To get the word count for VIDIOC_QBUF+VIDIOC_DQBUF I opened this link: <=
a class=3D"moz-txt-link-freetext" href=3D"https://docs.kernel.org/userspace=
-api/media/v4l/vidioc-qbuf.html">
https://docs.kernel.org/userspace-api/media/v4l/vidioc-qbuf.html</a> . Then=
 I selected all the text except table of contents and did followed the same=
 procedure.</p>
<p>To get the word count for struct v4l2_buffer and other types, that are r=
eferenced from it, I opened this link:
<a class=3D"moz-txt-link-freetext" href=3D"https://docs.kernel.org/userspac=
e-api/media/v4l/buffer.html#struct-v4l2-buffer">
https://docs.kernel.org/userspace-api/media/v4l/buffer.html#struct-v4l2-buf=
fer</a> . Then I selected all the text except the table of contents and the=
 text above struct v4l2_buffer definition. The rest is the same.</p>
<p>Also it's quite obvious if you look at them how much bigger struct v4l2_=
buffer (including the referenced types) is compared to struct virtio_video_=
resource_queue.<br>
</p>
<p>Do we agree now, that V4L2 UAPI is not only marginally more complex?<br>
</p>
<p><br>
</p>
<blockquote type=3D"cite" cite=3D"mid:2d5df33a-c246-81ee-92e7-a44712600e62@=
opensynergy.com">
Also please read: <br>
<br>
<a class=3D"moz-txt-link-freetext" href=3D"https://medium.com/starting-up-s=
ecurity/evidence-of-absence-8148958da092">https://medium.com/starting-up-se=
curity/evidence-of-absence-8148958da092</a><br>
</blockquote>
<p><br>
</p>
<p>This reference probably needs a clarification. You argued, that V4L2 has=
 a good track record so far. Here is the quote:</p>
<p></p>
<blockquote type=3D"cite">
<pre class=3D"moz-quote-pre" wrap=3D"">FWIW V4L2 has been in use for a looo=
ng time (including in Chromebooks
that do secure playback) and I am not aware of fundamental security
issues with it.</pre>
</blockquote>
But absence of found major security issues doesn't tell us much about the n=
umber of not found ones. Absence of evidence is not an evidence of absence.=
 At the link above a former Director of Security at Facebook shares his tho=
ughts about what could be a good
 evidence of absence of major security problems.
<p></p>
<p>So a bug bounty program with high premiums that covers V4L2 would be a b=
etter argument in favor of *already written code* in my opinion. Not for ne=
w code. Also probably it is also an argument in favor of the spec, that is =
the V4L2 UAPI. Like that it is polished
 enough. Not so sure about that though.</p>
<p>There actually are several bug bounty programs, that cover the kernel. T=
hese are Google's kctf, ZDI's pwn2own, and zerodium AFAIK. However the prem=
iums are not even close to the ones mentioned in my reference. Anyway this =
means, that using *the existing
 V4L2 code in the kernel* is probably OK. But this creates some limitations=
 if we want the actual code to still be covered with these bug bounties, ri=
ght? This means, that the host OS has to be Linux and the actual hardware h=
as to be exposed through a stable
 V4L2 driver, that is in mainline for some time, and there has to be no or =
little processing on top. For us this is not possible unfortunately. In the=
 end both things could be secure:</p>
<p>1. V4L2 pass through can be secure because of the bug bounty programs an=
d a lot of attention to the kernel in general.<br>
2. For the new code this doesn't work, so the spec should be as simple and =
device-centric as possible. Because, all other things being equal, there ar=
e fewer errors in simpler programs. So defining a subset of V4L2 UAPI inclu=
ding the data types looks like a
 good idea to me. The stateful decoder interface, that you point to, does n=
ot define a subset in the data types.<br>
</p>
<p>This is basically my reasoning.<br>
</p>
<p>Also these two specs don't need to compete with each other. They have di=
fferent limitations and they are for different audiences. If you check the =
XKCD's comic, it is about competing standards.</p>
<p><br>
</p>
<blockquote type=3D"cite" cite=3D"mid:2d5df33a-c246-81ee-92e7-a44712600e62@=
opensynergy.com">
<a class=3D"moz-txt-link-freetext" href=3D"https://www.schneier.com/essays/=
archives/1999/11/a_plea_for_simplicit.html">https://www.schneier.com/essays=
/archives/1999/11/a_plea_for_simplicit.html</a><br>
</blockquote>
<p><br>
</p>
<p>A quote from this article:</p>
<p></p>
<blockquote type=3D"cite"><span style=3D"color: rgb(34, 34, 34);
          font-family: Helvetica, Arial, sans-serif; font-size: 15px;
          font-style: normal; font-variant-ligatures: normal;
          font-variant-caps: normal; font-weight: 400; letter-spacing:
          normal; orphans: 2; text-align: start; text-indent: 0px;
          text-transform: none; white-space: normal; widows: 2;
          word-spacing: 0px; -webkit-text-stroke-width: 0px;
          background-color: rgb(255, 255, 255);
          text-decoration-thickness: initial; text-decoration-style:
          initial; text-decoration-color: initial; display: inline
          !important; float: none;">The
 worst enemy of security is complexity.<span>&nbsp;</span></span></blockquo=
te>
<p></p>
<p>I hope I've provided above some evidence, that V4L2 UAPI is significantl=
y more complex. You asked for one example, I provided it. For us this is al=
ready something to care about.<br>
</p>
<p><br>
</p>
<pre class=3D"moz-signature" cols=3D"72">--=20
Alexander Gordeev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

Phone: +49 30 60 98 54 0 - 88
Fax: +49 (30) 60 98 54 0 - 99
EMail: <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:alexander.gorde=
ev@opensynergy.com">alexander.gordeev@opensynergy.com</a>

<a class=3D"moz-txt-link-abbreviated" href=3D"http://www.opensynergy.com">w=
ww.opensynergy.com</a>

Handelsregister/Commercial Registry: Amtsgericht Charlottenburg, HRB 108616=
B
Gesch=C3=A4ftsf=C3=BChrer/Managing Director: R=C3=A9gis Adjamah</pre>
<br>
<span style=3D"font-family:arial;font-size:12px">Please mind our <a href=3D=
"https://www.opensynergy.com/datenschutzerklaerung/privacy-notice-for-busin=
ess-partners-pursuant-to-article-13-of-the-general-data-protection-regulati=
on-gdpr/">
privacy notice</a> pursuant to Art. 13 GDPR. // Unsere Hinweise zum Datensc=
hutz gem. Art. 13 DSGVO finden Sie
<a href=3D"https://www.opensynergy.com/de/datenschutzerklaerung/datenschutz=
hinweise-fuer-geschaeftspartner-gem-art-13-dsgvo/">
hier.</a> </span><br>
</body>
</html>

--------------H90StHKYugjae60XQcZZ7a0U--

