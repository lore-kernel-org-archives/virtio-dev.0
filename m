Return-Path: <virtio-dev-return-12252-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6536C77B77
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 13:13:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 00C7B2AC61
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 13:13:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 76D329863D7
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 13:13:45 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 628BF98632B; Mon, 17 Apr 2023 13:13:45 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 50B8798634A
	for <virtio-dev@lists.oasis-open.org>; Mon, 17 Apr 2023 13:13:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1681737220.812000
X-TM-MAIL-UUID: 8071f17a-19a7-4e58-b6bf-9fa733934d8b
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rg8lb6XDMO//b7hkmnp/ww4vMx0DnJANGlkQaf/wtToswVAF3E0LbaeXA/EFaomQZphS+bTVQTCXgIVnWC3h0QJ/cizNdFBO1hNGSL8gq8jleycbg+tUd407tz/jirMgb+at4+dFzjF4Mp7q4SrOnebwfzqW0xDUEaEKBM8ZIjNdKozqAKtfPAu6yuzSK3W3cjQQ3jghy81HBhi8tUB+NydjnUr3X3Zs3Xg4+VBjjq1sYkGPJmL9/oPaShE4Ju+BoPsziduJjabJM7kWzoP0N5FZCBPegcGBLyIHoI5cEYwu2jI5Zssf7ZMwZnUc5i5anx54AZWXpob6G8L5xAvfHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8pJghdkY+I8DymJMLRX+XqqdTo2peV+Ka8TowehHU4=;
 b=KvifRbWWsp6BvorR/vTkLckwqy8uCnikXNoCDMjv10L7zcVxF/0nmBtvnjBTRzhcs5XNeHy44erqaU37pT5d6fDlWpWfp2MUojWsj+Jt8/nTs2Ui9rwGC5DxVNNxuxYSOeuCLOG0Kz1k/3tOSb7XmbTxFUjpnyJITyorxnV9DKplKqLMqIV43iQCSOqM5LTI1vk7Y4Kylejz6LaUE44sVmR/FqeB7CeM9aYT0Y4fkfZPbj5aSJAEGdbTmQpeAfA1C378L+HNte/2vHkqcWKC4ZBQcWm7B2McLN4e5B/CFOhGE2XVqqNtEXX8pgYwuZMoDSwN54BoHiQZWsFtZ0h2EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <39649cbc-f8e3-0ade-f8dc-b46a537710b7@opensynergy.com>
Date: Mon, 17 Apr 2023 15:13:35 +0200
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>,
 Alexandre Courbot <acourbot@chromium.org>, Albert Esteve <aesteve@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Keiichi Watanabe
 <keiichiw@chromium.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Marcin Wojtas <mwojtas@google.com>,
 =?UTF-8?Q?Matti_M=c3=b6ll?= <Matti.Moell@opensynergy.com>,
 Andrew Gazizov <andrew.gazizov@opensynergy.com>,
 Enrico Granata <egranata@google.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Bart=c5=82omiej_Grzesik?= <bag@semihalf.com>,
 Tomasz Figa <tfiga@chromium.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <5fa6dc30-af86-e58c-2d39-fde2836192c3@opensynergy.com>
 <CAPBb6MWqqAFB+g=JZu9-VgZbEJxS3wYaEgA-R_P=OyHRTHy7eQ@mail.gmail.com>
 <8ec36252-97c6-0378-e25b-fc972ea3a66d@opensynergy.com>
 <CAPBb6MVDKfKOyDFPiOL3fRp4Jn6WwMpSZt6V32EJ1CYW_+rw+w@mail.gmail.com>
 <909867c6-b66c-1281-45a7-38fd0aa32123@opensynergy.com>
 <87cz6mnaqk.fsf@redhat.com>
 <CAPBb6MWNfPH+e8=4zUcq2dV-59OdzTYSuN04Cg2rRPWao-nseQ@mail.gmail.com>
 <877cwttw2x.fsf@redhat.com> <87a60kg9rh.fsf@redhat.com>
 <CAPBb6MX+R-bDgJzracbZq6DE7B0WO=rtqS6GE1QDugdrFLryXw@mail.gmail.com>
 <877cvog030.fsf@redhat.com>
 <CAPBb6MWyVoEuXJoKvJhP-5zp-x5WrDwVWe8mxbXbCwyzfgqW1g@mail.gmail.com>
 <CADSE00KD9=2hs5b=fZpTe7XDm3Q3PAmQczGciE=zLBOF3UNLBA@mail.gmail.com>
 <CAPBb6MW6RxdaH_kq6ZsWpP78yGBSP4T6p3E4=O=uKje4P+MiFw@mail.gmail.com>
 <87ttxek6pb.fsf@redhat.com>
From: Alexander Gordeev <alexander.gordeev@opensynergy.com>
In-Reply-To: <87ttxek6pb.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE1P281CA0303.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:85::17) To BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:4d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2663:EE_|BE1P281MB1745:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f25d90f-9c38-4856-74b0-08db3f458ef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b9juIeWPE0tXxTNCz1R34G05FbpJklYjtEFBEwH/QmboewmGgaXT+DNDd/ch6lgWvFc8HrfnOEYCM5Cct6NQLfxTU9/FMKQyxWmIH/yUFaPtWHK0bdWnYCKi/uEzqWftHXQSp6cwxHU7t/d3qNLLTii2+w4H2O/cR6adcPMmjN6iugizGBfJF/jNG6V2QTbNsZOlI+PN6dCbBk6/4V+xMFrV3+iInNTfOFskRGFt1EE5JJqnV5Iw/Xv3Y95yaBC16tjOxhw29fyh4F4pvORP0NWOk1+hVebaB7wzkS6WcdvD7nY62hUtLqA3N16q/Usm3USU1EPIp5jWhseKeONHk9/uAIZ1MdptBDHLcp6v/ShBiX+hwVl8Jeaw8ELm2ZGffW17g1wwPpv+0BJPWYPb67AWF5wVxmLzRXcdSm4bMekrmmhJx3DUdC0rUD05smA4Y1rvejSoGJ0Isf7Tg/+UFynItswulyG4l+FEDLSbz+vXFQNS/Ke9lfVBsqSHj4VsyxS9HgTqIQPiRy6qwYov4yrx8IMn0OgOuYQxJ7kem5w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(39840400004)(396003)(136003)(451199021)(66476007)(66556008)(66946007)(66899021)(2906002)(31686004)(4326008)(2616005)(7416002)(5660300002)(44832011)(8936002)(316002)(41300700001)(86362001)(36756003)(110136005)(478600001)(42186006)(54906003)(31696002)(186003)(53546011)(26005)(66574015)(83380400001)(15974865002)(8676002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDJGdUVUajUxemY4L2JZYTJXUkpEUTJhVlRFNXBQeTd6MkFaekcxVXViQ3o5?=
 =?utf-8?B?V3RocStLdDIzY1hwREk3dmwwUnVXb205c0lNL0tCQ1UrNzVvcXJXdnNGQzVt?=
 =?utf-8?B?bjhmQTlyLzUwdlVlbjl2NmV3MTZOTlpXNm96dkREd01FanNWSFZsRzZEVk5P?=
 =?utf-8?B?d2g4eS9zQjJBWC8yaFdOWWZmeWYzMm92UkozMzVLZEZ2VjR1OEsrK1huOFJL?=
 =?utf-8?B?WmNOM3hTb2NHb1JncFBsL2RyUGEraS9rY1BvSmdpczUxMmJ3OFF6R3hXalBG?=
 =?utf-8?B?VzZRT1M1VUd1Ly9GN1lLRTJpZWI2dG9rMFRsSGF6djNxamdnQVpDVzVWMThT?=
 =?utf-8?B?eWdDRllFVnJQeXFweGJjNG5NOWluaHNVQjlNSlJWRDNJQjFzVWRpRWpYMGhh?=
 =?utf-8?B?RzhsRHVaQ2RxbzVwUUo1U0xPYnFzRnUxY3R5Ym1BakRNUXA1SlFWT3pXR251?=
 =?utf-8?B?TDFjVWJnK3V0ZUNTTnVuamhzSGRIMys2N3NvbUNWN0ErQUl6ZVNXYjYwREk1?=
 =?utf-8?B?YWlNQVFCV0dhOU1zVXAzazlod1ZYODVncGtGZC92b3l4NWFEOE1EOFlUdExM?=
 =?utf-8?B?NjMyRzY2YXlnbmJGU1lFZTdyQzBiN1VuTkN0b3lxQXBJeXJGVk9jY25LMy8x?=
 =?utf-8?B?S21CVloxMWN1NGVSbHN6RGlGckJNeEttQUo4VFAvTm91NmppYm80dy9iOUpI?=
 =?utf-8?B?NFJ6Nk5YR3RJd2lZS1lpQkt2bFg3dWMvTkhOSHlYS0c0QVN3N3ZUa3FuZ2Ry?=
 =?utf-8?B?ZEU2S2h4WDZpVEwvTVRSM3djMGloM2IybXozWHR6aUI1eEdIbGxNbWNlTlIx?=
 =?utf-8?B?czIwRmYwTjlXQ0hYQ1RDcjVQUFcxRFppbk9nb3o1M29WMnpTT0UrMTBGeFY3?=
 =?utf-8?B?cDhGNXdpT0tka3k3MWhjS2xuR00ydHRmRXgyOUs3d2R3amxVSVVqNk9OMTlZ?=
 =?utf-8?B?aC9aNkRSbE1TVVNReXo2V0dwMFlzU1hGdmx5QlpueUlvSWVRbDZSc0I2cWJP?=
 =?utf-8?B?UU11NmNucWFheDNZdXY3SXNYRkszV3A4U0NZSlByQVJYVzgza01vZXVlNzdF?=
 =?utf-8?B?R3hVQzNGdEdVdHplVFZxRnlVMDF4cVNTN1hhNDBUVE1SLys4Nk03d3pFRXZu?=
 =?utf-8?B?ZXNpWTJxVnBqM2I5SG1zY1RqVXlzelNaZnI0WExSeU5HRFRVOGl5UTZjTFho?=
 =?utf-8?B?Y2p2UVNpUStiSUR1WG5RYis2ZVF3RjB1ZnhCMDlhb1NRQldEbXFRRFFxRmtt?=
 =?utf-8?B?MGJ0c0k2QVlGT3paUjZXMlY4eDJ0YllETFFRb3ZMS2swY0NLUmhLV2N4czNK?=
 =?utf-8?B?MWI3TGNoNWNXK25sblJHWXFPdEI5cHRHNCt3M1FiVVYyRkR4Wnd5TUpIeUJT?=
 =?utf-8?B?MUIvbVlkM2M0Wm8yS081ZmhkUFZoVk1KdVlNdzg3djMyWVRtMnpNRXNQbm1K?=
 =?utf-8?B?WW1jSmplOXE1dm5TL1VEYXpPMzFpakc5dUVWb09WT2RncDR6MFpTVXFGN2Ns?=
 =?utf-8?B?aHlRTmo0Q0tBbkM1bVQrK1FRbnpFNGJXekNjVFpGTWljcjdJVDgyVlVTSnpQ?=
 =?utf-8?B?eXJkbkp5Zllqdk94dFFPKysrU1lRUDVzZzB0UE9HblhpZUNLVzlSL0VNOUJn?=
 =?utf-8?B?Q1hXQzNVUGsvUXJjdTd6TTR2cW15czd5RWxxQS9rcnF2N1JQZjI5dTZ2NG1F?=
 =?utf-8?B?b2luR2V6ZCs2eGt2Z3pjdDlkS0NHZmVDaXphVGJSSitlUlVuMXZNekZPSHMw?=
 =?utf-8?B?M0dMN3lUVjN0RnJncHBJVHNCNEJIYUZnTFhxdkxnVlM2OUMzeW9nTG9TU0Vw?=
 =?utf-8?B?U0Nnb0xYZHJGbExvL250R3lyWFkrWmJpTDJRRnFiYUl6ZTlxOUhoVmZDUitq?=
 =?utf-8?B?R2lTT1kvZi93MGVBUzJBcUhsVFZ2WWI1YktkV2V0UDhXd0xwMVMvMDZxeEtz?=
 =?utf-8?B?TC9RdURlVllBejFGMzRMelZsMnFvcEgyenBYYmRQeHpxU0FEU3VwMGF5VWxk?=
 =?utf-8?B?NU5WWmd6N0ZTeFlmclhEZzdaSlFIbnJzSmxDT2p0Rit1R1dCbWFUWU0ySkV3?=
 =?utf-8?B?dE1CKzNnTGNNcmxicjBHUkJrckJpc004bDlSZ3pPWXBibk9wWmF1N0ZpUDMw?=
 =?utf-8?Q?4OND76fahSsJbpPiQWDowFBHc?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f25d90f-9c38-4856-74b0-08db3f458ef6
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 13:13:38.8364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M0b0st3IBoPsNz28FYZ7eO0Dxi+umNHLClHTXyzoK/+EEjrGCNPxgh/6AhJA9cP4LKoZK7/BJKg09ymJ+n+2fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB1745
X-TM-AS-ERS: 104.47.7.170-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1006-27572.000
X-TMASE-Result: 10--14.929400-4.000000
X-TMASE-MatchedRID: xcONGPdDH5r/9O/B1c/Qy6n9fPsu8s0a9mojSc/N3QeqvcIF1TcLYOFo
	/YmgpQJJ9m+tZBSEc5R/c62vDEKji3DICbPFvtnTGqSG/c50XgPwUenwsKlntI4QQ2CxQC5iQnU
	C1jfTwgsWmhpS5SD4mmsJeL4IB6ccrFMDyJP7G270hv/rD7WVZA60tXhQ0Rt4hzldYl+vKimocL
	5CYnjHAkf5qRfo3zxMktE9njlcy8ZnFeLGH6jGHtKDcT1f9CjE6KjY+CtcuzhvmNicZzSvYc65Q
	ern2w9CywMD+nV5RTgOpmVTrU4wTF8+dSqKgz8/dhkilCSjv7UNW4va9iqt3pC/BCs92qoiMVdf
	MsaGcAtjvTA71MypWv/EMEB+Cg47qJIiwhbq5S9M0MpnLn+G9C62GA8VkuOa/e5hRw9VtK5S3eA
	HzSfkkLs8IMNI7NJ6uXFEQJaCEz6/WXZS/HqJ2modc419PBJCxEHRux+uk8h+ICquNi0WJD8i/L
	KXqbPqMAqAgIM8cEgaQXlX2W6+r7hwM2cuGH3bftwZ3X11IV0=
X-TMASE-XGENCLOUD: 801ef88b-f954-4ec4-9bde-cb8f66d8abbe-0-0-200-0
X-TM-Deliver-Signature: FD40A2C57B2C298A0FF692397386CB5E
X-TM-Addin-Auth: dG8v7rN8xq3s5SS9FqAWwRPxmQFZhRVXzCvwcD8cltxLIMzBxlZLnVifcp5
	f18DxuixktiuD/zM7uqvOvUbqR29HaL37lP8KUMLL5z6xPh8ebGU/eNBzCsNzhXHXO2xZLTasL9
	BPUh4RSnK3JIRAudomB9HjCmRdEbglC3JkQAQvd8o/7FR+qQaJMOGm121SQXIIeZerB53MSvlKx
	KThDkgWkYG7EnGPzPFy7OigSsZ9fxhw5Ccc1bLTuqTQDKcwPBFBjOuGj8XLOSaAgT41x85q5yiF
	+M6/kAJw/0IARxg=.eEKpuOQULDAS9ygnZ51V0Qi/k7ztWz4qyBjZi2UDrlvIPvvvxeHAhvc7VM
	Kri1W+wtUgRuOvl0m3mXFBoKZrQ4E7XJmE0e9rOohtgndKMKUjWQGI5475ji6FJLqroRGRKp9k8
	DauloVF/l0sKFGAUg5AKfXxMCTpRvNTIs94hKQjfqYpmGGTr0rM+mG/Tz5TTHdgYlxvQwwO2Eit
	+GviDguy0RIxFzKVfonvTCwsJ2kMiWaFW4Ko3YJTqZNSrCK5GKd5vqnqLlogbaxqf7I1WKqdxGO
	57NGI4SBFcD+WTgFsSOfr59dhgfbok2VwLkE2mHYVXjCtpT9MolSymshfyg==
X-TM-Addin-ProductCode: EMS
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification

Hello Cornelia,

On 17.04.23 14:56, Cornelia Huck wrote:
> On Sat, Apr 15 2023, Alexandre Courbot <acourbot@chromium.org> wrote:
>
>> If nobody strongly objects, I think this can be pushed a bit more
>> officially. Cornelia, would you consider it for inclusion if I
>> switched the next version of the specification to use V4L2 as the
>> host/guest protocol? This may take some more time as I want to confirm
>> the last details with code, but it should definitely be faster to
>> merge and to test with a real implementation than our previous
>> virtio-video attempts.
> Yes, please do post a new version of this spec; I agree that an existing
> implementation is really helpful here.
>
> [I have proposed July 1st as a "freeze" date for new features for 1.3,
> with August 1st as an "everything must be in" date; I'd really like
> virtio-video to be a part of 1.3, if possible :)]

I sent an email minutes ago with an alternative plan. I'd like to
volunteer to continue the evolutionary changes to virtio-video. I'm
already working on the v7 draft. I think it will be available next week.
Then I'll focus on making the driver V4L2 compliant. I think all of this
is achievable by July 1st. At least the spec part. I think the
revolutionary changes should be in a separate namespace. The rationale
is in the longer email. WDYT?

Kind regards,
Alexander Gordeev

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

