Return-Path: <virtio-dev-return-12341-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C45C7618E
	for <virtio-dev@archiver.kernel.org>; Fri, 21 Apr 2023 14:50:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E27292AED1
	for <virtio-dev@archiver.kernel.org>; Fri, 21 Apr 2023 14:50:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C5F35986638
	for <virtio-dev@archiver.kernel.org>; Fri, 21 Apr 2023 14:50:24 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AFDEC983FEB; Fri, 21 Apr 2023 14:50:24 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 83D0E986636
	for <virtio-dev@lists.oasis-open.org>; Fri, 21 Apr 2023 14:48:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1682088532.537000
X-TM-MAIL-UUID: beeb981e-8568-448b-a5d4-6441c4d9afc2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGE9Z/sLnYaI8vpsr86advOYw7q4qDfULCWANjr/rgwZdoM0p40IA88iNLT4U5cAN3iDz7sNLTMu0BoAw79oY7GfPDePkbWs/ylS6Z2vqGLQVpKPL0DqrqPMJP0qTzWsncC4nTILwHW5cVQkOx4TxaZetQy99rtgi9Ua33NFjows1pj2dACQ+LhILfVEhq/ohWBNuH+OrdW4ft8fY+xJ/dBG6yvl6NvNpBeS5tdBqf5r6g5qzZm1Ffax5i4d/OIEyKd+p0gUJeFbTUdab/jCxzZVjYhRs+ovdntQ9nDkstsRSczsY84yv6cGZ0BaYLc0glbFoM7KGGx4Qvyy9+7plQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05drFbwu4Cfj7y9JEi0y6sIOI4VZBMw8jcX//X9gNyY=;
 b=KrwWuy3WO4wstXuFoStFYcLTKfGKuaGACnRD3rdE5OSPvU+7MPDEoAkfty3mA8eIAsuWnj89zbY5CAYM8Bzy9gJugt4LPWbAuikczzsyYDXFofj8QyG0zHrEoq5cyp/+izeVGPFZdj9+LeHZWy3R84ntLSc2IcilMjWK3FiRxWBiDmoH1gRZazrF8yUWu6HjNwDOwk1bjoc636KkjSqhDRd8OUTr02FkS6LH4s4PDbV6qtyj1rBWtfWM/JHckjY/jkW1/xPGOO8jE7X1aW3wAY6KyZEItXfT+YMZicVUKEN9UuhbaJspGqB/WREwtQk6I0Ub8dbh43S5SzeND/NXMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <033d8715-b541-5641-508e-71a8edebebce@opensynergy.com>
Date: Fri, 21 Apr 2023 16:48:48 +0200
From: Alexander Gordeev <alexander.gordeev@opensynergy.com>
To: Enrico Granata <egranata@google.com>
Cc: Cornelia Huck <cohuck@redhat.com>,
 Alexandre Courbot <acourbot@chromium.org>, virtio-dev@lists.oasis-open.org,
 Keiichi Watanabe <keiichiw@chromium.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Marcin Wojtas <mwojtas@google.com>, =?UTF-8?Q?Matti_M=c3=b6ll?=
 <Matti.Moell@opensynergy.com>,
 Andrew Gazizov <andrew.gazizov@opensynergy.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Bart=c5=82omiej_Grzesik?= <bag@semihalf.com>,
 Tomasz Figa <tfiga@chromium.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 Albert Esteve <aesteve@redhat.com>
References: <20221208072325.2259940-1-acourbot@chromium.org>
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
 <ca84a8f5-71ed-aea8-5751-60403d167283@opensynergy.com>
 <CAPBb6MUDWVK87_kGFen36tDJQoR-Les6djcKVihjuTKQBjweEQ@mail.gmail.com>
 <b5c9d69a-fbec-8046-225f-bdb5850bbd54@opensynergy.com>
 <87o7nmk1rs.fsf@redhat.com>
 <96978ce8-0837-2e08-f5ca-66587807798b@opensynergy.com>
 <CAPR809sJBLAgLNyB7nCO6+izQgAAUiOLujV98+q_H8bcPEzx4g@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAPR809sJBLAgLNyB7nCO6+izQgAAUiOLujV98+q_H8bcPEzx4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE1P281CA0247.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8b::13) To BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:4d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2663:EE_|BE1P281MB1715:EE_
X-MS-Office365-Filtering-Correlation-Id: f3f8d614-b9bd-4c7e-6916-08db42778549
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CDsjlSe3YBUlP9KKz5qzuAlg/ksom4FxeOWoLplirkl4KAXvLjxrYVq1aBUpx/6WMozetUy7Z34NGiv9VK5AtXwsvKts3QOCUP1cOGibPRFCyI+ru4zaLFtz4I/ojyjxRXMtteKaTgdkK2YDnAgYXK3e61jhGnb2D5Qj6kykbq3kvLSDCXn5hkQMl9A45buqNyf1qUpAJWdbGoCuK+0okoQKkifc3ApqEKE5OqX6KMhlIOPLOtQsKO/okFfu2j2PAi+d9DaUyocSoi9lu/nT3L8XFq3jWlAMrpKx6c086P9K20w2Ii/Wt9jjBSIbvLvibPsuv8DZ8QjtdNRxL0eN4hVPXggVL0xcB6gBUj8mdibWsRKln2gjxEb6FIwCUEbAF0YGrGrlB46DiWG3vrohDV+NoJlSOEzhBHizBQTIhytlwTEmv/vqLnsytLCd2Qasah5ODIuXErvJh0KE3LV5uaPOhHvasGgfugjPDHiv3sHcOfN6a5duRysuGYBDyoQOdXob1k2SIcIGEOaCq5e5cAQHR0Aidua5OqtLZNO700whginCh7AYEZr5IN4aJuIYFg40DQ87Pbj9oulW4eSMig==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39840400004)(136003)(396003)(366004)(451199021)(2616005)(83380400001)(66574015)(31686004)(36756003)(186003)(15974865002)(478600001)(54906003)(42186006)(66556008)(66946007)(38100700002)(66476007)(66899021)(5660300002)(8936002)(8676002)(4326008)(41300700001)(6916009)(316002)(7416002)(53546011)(2906002)(26005)(30864003)(31696002)(44832011)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWdGcTJoeXQyRjRiLzJPK3oxK3pjTzlQYWFlSUJ3RGQ3WGt0OGNCVXlTOGo2?=
 =?utf-8?B?Y1hGQ0R0aHlkUU1XNldwR3hwMUgvU0pUK08yaEZzN21ZWi9BbURZVTUwV1BC?=
 =?utf-8?B?ZVhxUXJyNzVUc0RxZEFiVzVwdEdrWVhoc016TGI0eFRvdElReGRIOVdEV0dG?=
 =?utf-8?B?YXFFNVdodTNSb09NbTloWVVTTVlXRW8xSjdqYkJGQlJ5MjlKTW1BaHVMTVZm?=
 =?utf-8?B?Y1djZnVWalpsTEU2TUJiQ2hXQ0lxWFUyaEMxMzExV05uSUFZaS9PT0pNQmRp?=
 =?utf-8?B?SnR5NTA5ZTQ3WXBBOEpQUVhRMXV6T2IzZUM5ZHJOa3g0b0lDTVc3Y3oxWEFS?=
 =?utf-8?B?ejdEb1UvbTh4dWR0NnZ0N01kWnJ6SWlkWDBxT3Q4SVJlQWN2SUx5M096YUZM?=
 =?utf-8?B?Z3RaTUF4Wlhuc0t2RENPVk1mU0VUSDJOVEJ3djhKMmdIVVlEbG1CZFY5OG9K?=
 =?utf-8?B?M3lkS2RlcWdHZ2czSGRET1gyTnMrbDhLZ0xnaUxQYVRYcHl6L3dXRDREYVZW?=
 =?utf-8?B?VDFzcHVYN3VvR1ZPbUE0dU5lUUlOazlvdEJWaDd3NnAyM3U5YmZpZEpKL3hP?=
 =?utf-8?B?eUZIR0pteVF2d29JMzFrZ3JEaDgwZFNGUFlNSE55bldUYU4wSkVTOEJnQXBI?=
 =?utf-8?B?T09oWTNmU0d0NG1XU3VTQnN1ZUJJb0QvZ0t1OXFmUFYwZEFNRzdzVDByTlZI?=
 =?utf-8?B?WXV3cC9jd0JuZEsxVGpLajMrdHU5SXRsdk1YNGdCMnNmdWFhd1Jybzl4NjA3?=
 =?utf-8?B?S0t5UUY3VVVWS3RraWNSQStkWmV5eUdSTjBNSVdEYmNVUEJFb2pVb0dibnVv?=
 =?utf-8?B?cFcwSnZYU0xrMzVpZkhIaDhlODM1NWlybU1KOUhJZ1RNWXg1T0tGbWxaNFhv?=
 =?utf-8?B?d05WOWNMOVRyRGtmT3dGQ1kvd0dQcFF6NlFHUTBtdURqRnhnODlMVnlDZmk2?=
 =?utf-8?B?eW0zZlJZa1g1TUhsakE2RmJrVUhvK0Q1Y050L0xOelBBQ1Arc00zMUhFYmpj?=
 =?utf-8?B?QlBNM1kzcDlDaGpvYlZlWjRKWWdTa3ZlQ2dhOHdyby9TL1J3dnQyVjlaS3py?=
 =?utf-8?B?LzBPbGorVW9RY2NFOFE0clhFSVFXS1Q3SDVTOWpsbnl4N1pjaFYybWNrL0pB?=
 =?utf-8?B?SElNYmUzWlhkUnBKQmtMeit5UmlmS3h4Z3FEa09YWEpFOUQrR1dYSEhFR0Er?=
 =?utf-8?B?U29ER0dGWnk0V3FRWHBuTlRmM2U1UmljNUJldzl1UVVUN3hrUVFWSy92Zlhv?=
 =?utf-8?B?RHBmd1gza29MdVhMdmtCR1hpZ1hISTNxVnRzS3RxN2FETG1pMFZ0MWZCOUY5?=
 =?utf-8?B?ZERqSjQ1QUZsZ2FJSytmdHhIenMwNmIvcy96S2hOSTdvTlc2dU04VlB4ckJM?=
 =?utf-8?B?V0lCUzh6VWxxQWhaSWJBV04zaGJUcEtVdHdrVXppQm1VZnNEQnN5N3haY25x?=
 =?utf-8?B?YU0wL1hNQ0hPUGtTVkVNd2lwdFJjUnJjRklGVldzRFo4bUdYZzlicXM0ODRF?=
 =?utf-8?B?SmtRSDc3RE5UcFdieThlRHZhQTJkZkNJU1FzR3BJRUpPa2lHeWZlSlZoYVlK?=
 =?utf-8?B?WTVVNWJkZGtuSndTd09DRHllK0w1YVZBMEZpUnBacVdydFpCanZLWVpwQTFP?=
 =?utf-8?B?Q3UyaUNlMDB2QWR0aE1SRGZTWGxsdUJndkxGS29wYmhrZlFTWnJqL0czd3J1?=
 =?utf-8?B?ODJtcjlGcWdxRlBCVnp5RWt5KzBUd1JSSWJVd2o5UzZOYnZxZy9NQS9jREdl?=
 =?utf-8?B?b2Y2MzRhYm1SWVoyajFyYWo4dEtDM05tdTc3N1l0SXVpc0M2aDd3WnBVOWR0?=
 =?utf-8?B?bndCV3k1VGlUSk84cnkrenJvV2dvQ0N2ODU4TjlCNE02YjVkcGFyeGd2aU14?=
 =?utf-8?B?QUNSQVZ2MmZqN2ttajZwRnBBNGNLOWRtZ21XNWN6Q3hjZEJhOHdsUWdwMmtx?=
 =?utf-8?B?K2NSaFZoZXdKSkxsSzNmTFJ3djd6NFoyWWdYcm5mNDdzN1F3UytqTmF1b1R3?=
 =?utf-8?B?Q3hsVnRCTEZib1g5M3g4blM4bjVnUE0zbW82MU9MSzZ0RHEyZEFlL1J4RTlM?=
 =?utf-8?B?TWMvRlRiODUzai9LSDNXL25yQmE4V20yWmZMSlFpVTRHSkhFdzV3VFFZWU14?=
 =?utf-8?Q?SnBP/q7T2tNkexQxqIbttaTlV?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f8d614-b9bd-4c7e-6916-08db42778549
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 14:48:50.9157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HznlV2Frf6DNjfELyhEnZuJc0rIvGIeOyjU9/et+7VLpACPsYteJjitwP/xev5VrKCL8DVgRXWJrWxfndWKtoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB1715
X-TM-AS-ERS: 104.47.11.177-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1007-27580.000
X-TMASE-Result: 10--27.014600-4.000000
X-TMASE-MatchedRID: jFqw+1pFnMz/9O/B1c/Qy6n9fPsu8s0akYC3rjkUXRJ68VpiQd7QGORZ
	+ls/484heez4oHhYoxmaJifgZi7hpYd1E9CxClKsOqiOey6h/Rxu9fR09mKmg8xAVSZpctEFINg
	IpAA8LuOW1rCYd0kRoqloc6WqrZaZaP4yyf1DpWiVfW2tZEcOk51RK3LcPTO7lEFkVZA0Bebjo+
	A3552ljei4mlshA6S0KoH+ePJ0JfmjeyfNFhJjaptL4KZUdwMSohrMq0nEhQcuBXgf4CFdLCRmd
	HeCks1SF40HISqSK6osXygcgbAengIpumv0J//wueYB1mSXzr/GnIztpkKhQgrkj7klVufusroa
	YqmkZ2rHyjn2xyeLrBQpEZMR1RYSjUPFUUIcEyeJJ72DuZB0nJqzeC0+8vPg6DfA0qKLWvmy+0a
	swthUHW+a/7zeNtsdFTxIpntvkVX/R1NSMc2qCU4qSw2jMpR90w14HFJQjaMfaBJLrllK9RD46v
	/Okpva0zQvIGSf29AY4lCW9PpF6aXUs7kD79U2n6y0mNkW0aQA+JHhu0IR5nh7+7pZ9mZR1NMPi
	5DV0uFl+KZhG9Ijo5HcUYm6haBRgoztJ4SEo03ZTwWjL067hq88H8Y4FXgtLX3qyf3ewG8UGMup
	qAk+Ey07T/gbUnG6w3mhNuqvor6yReuuJNV7XGRCi/VpaMTXrBhOpvw6SYu0TREzfypUml3w8qW
	NACopsA502JwhhUFThQgwzlMBUfO9pVzJUK6dXTubK8QEAhnNKdtHc3A3XAAheUymmndfXoM4mh
	3keydbGM5QOQjnIGvtvwKw8+1B6NICqAQUc89+yskgwrfsC30tCKdnhB581B0Hk1Q1KyJHtBsf5
	/UXJbVQu1GNZ+si4kYXbobxJbLyU/oX+tpNmCG2Ull2Wedt
X-TMASE-XGENCLOUD: 1b0ca052-3871-4683-8040-1c7bdfe012aa-0-0-200-0
X-TM-Deliver-Signature: 02C5EABC92C5B611D8BDE530EBC9DE4E
X-TM-Addin-Auth: 1G4TM2V8cL37OoIDF5FKvoy+O8q5jaiWluEXybJb5KMIS5IZqbYQfD+FobL
	vd/4Oqjr+bQkwbglEqmxEHG5wh941/rOaKH8Wy8Eti5JJOPUFe9KnbocqeTj3tPfkMWz8w5UkEP
	B8wFfvnlA7i5WEDPFeqpjsGDlYVJZnm0LA+BVpUrohstqkYwQ64FuuWq9fafhgvISg0Ht/SAq9I
	Pqkx0Esj4yiw4LRwxqzkK6OggjuAHUeHP/Ry7hVuByAWYmKIePmxNj7AxbWRtWkHgHcKEtvJ2R0
	qqazIeZdMMi+MYM=.Ohn6sYXylE5rgWH3mAHkyTHcMptwITilAfdeRq5x74GBAGpArbbcoyEI7o
	O1qaIFOYeDa0WrR6LvWiThSn82Uf3AwOExg5kjBkO3GI5mUbS2AP44mRovmm+CeeHy3YtNManLo
	RxIBJeUMmbtotVsdRhAw8Lx/y6WEPXaCf+dp171MMfpIuPhx9YAqBWdCiRwiPN58nvZuwt4Z8Bl
	7J+vz9iTkHM+aGCPfsOqK0/iLw7i8XQGVAGznZ3zi6EdF5R4TvN1a0rcmu3T5ymlxncRgt9sfbU
	lowIqinuJ5l5z8+Z+QO0ShkgWBH6cfHodrtTislbhw4t4xma/C7y8vrIDKw==
X-TM-Addin-ProductCode: EMS
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification

Thanks for your feedback, Enrico!

On 19.04.23 23:34, Enrico Granata wrote:

> Inlined
>
> Thanks,
> - Enrico
>
> Thanks,
> - Enrico
>
>
> On Wed, Apr 19, 2023 at 12:39=E2=80=AFAM Alexander Gordeev
> <alexander.gordeev@opensynergy.com>  wrote:
>> On 17.04.23 16:43, Cornelia Huck wrote:
>>> On Mon, Apr 17 2023, Alexander Gordeev<alexander.gordeev@opensynergy.co=
m>  wrote:
>>>
>>>> OpenSynergy, the company that I work for, develops a proprietary
>>>> hypervisor called COQOS mainly for automotive and aerospace domains. W=
e
>>>> have our proprietary device implementations, but overall our goal is t=
o
>>>> bring open standards into these quite closed domains and we're betting
>>>> big on virtio. The idea is to run safety-critical functions like cockp=
it
>>>> controller alongside with multimedia stuff in different VMs on the sam=
e
>>>> physical board. Right now they have it on separate physical devices. S=
o
>>>> they already have maximum isolation. And we're trying to make this
>>>> equally safe on a single board. The benefit is the reduced costs and
>>>> some additional features. Of course, we also need features here, but a=
t
>>>> the same time security and ease of certification are among the top of
>>>> our priorities. Nobody wants cars or planes to have security problems,
>>>> right? Also nobody really needs DVB and even more exotic devices in ca=
rs
>>>> and planes AFAIK.
>>>>
>>>> For the above mentioned reasons our COQOS hypervisor is running on bar=
e
>>>> metal. Also memory management for the guests is mostly static. It is
>>>> possible to make a shared memory region between a device and a driver
>>>> managed by device in advance. But definitely no mapping of random host
>>>> pages on the fly is supported.
>>>>
>>>> AFAIU crosvm is about making Chrome OS more secure by putting every ap=
p
>>>> in its own virtualized environment, right? Both the host and guest are
>>>> linux. In this case I totally understand why V4L2 UAPI pass-through
>>>> feels like a right move. I guess, you'd like to make the switch to
>>>> virtualized apps as seemless as possible for your users. If they can't
>>>> use their DVBs anymore, they complain. And adding the virtualization
>>>> makes the whole thing more secure anyway. So I understand the desire t=
o
>>>> have the range of supported devices as broad as possible. It is also
>>>> understandable that priorities are different with desktop
>>>> virtualization. Also I'm not trying to diminish the great work, that y=
ou
>>>> have done. It is just that from my perspective this looks like a step =
in
>>>> the wrong direction because of the mentioned concerns. So I'm going to
>>>> continue being a skeptic here, sorry.
>>>>
>>>> Of course, I don't expect that you continue working on the old approac=
h
>>>> now as you have put that many efforts into the V4L2 UAPI pass-through.
>>>> So I think it is best to do the evolutionary changes in scope of virti=
o
>>>> video device specification, and create a new device specification
>>>> (virtio-v4l2 ?) for the revolutionary changes. Then I'd be glad to
>>>> continue the virtio-video development. In fact I already started makin=
g
>>>> draft v7 of the spec according to the comments. I hope it will be read=
y
>>>> for review soon.
>>>>
>>>> I hope this approach will also help fix issues with virtio-video spec
>>>> and driver development misalignment as well as V4L2 compliance issues
>>>> with the driver. I believe the problems were caused partly by poor
>>>> communication between us and by misalignment of our development cycles=
,
>>>> not by the driver complexity.
>>>>
>>>> So in my opinion it is OK to have different specs with overlapping
>>>> functionality for some time. My only concern is if this would be
>>>> accepted by the community and the committee. How the things usually go
>>>> here: preferring features and tolerating possible security issues or t=
he
>>>> other way around? Also how acceptable is having linux-specific protoco=
ls
>>>> at all?
>>> My main question is: What would be something that we can merge as a
>>> spec, that would either cover the different use cases already, or that
>>> could be easily extended to cover the use cases it does not handle
>>> initially?
>>>
>>> For example, can some of the features that would be useful in crosvm be
>>> tucked behind some feature bit(s), so that the more restricted COQOS
>>> hypervisor would simply not offer them? (Two feature bits covering two
>>> different mechanisms, like the current approach and the v4l2 approach,
>>> would also be good, as long as there's enough common ground between the
>>> two.)
>>>
>>> If a staged approach (adding features controled by feature bits) would
>>> be possible, that would be my preferred way to do it.
>> Hmm, I see several ways how we can use the feature flags:
>> 1. Basically making two feature flags: one for the current video spec
>> and one for the V4L2 UAPI pass through. Kind of the same as having two
>> different specs, but within one device. Not sure which way is better.
>> Probably having two separate devices would be easier to review and merge=
.
> I agree with this. It may be worth renaming the specs to something,
> say virtio-vencdec and virtio-v4l2 </bikeshedding>

Well, personally I'd prefer to keep the virtio-video because vencdec is
a little harder to pronounce IMO. Also after all I'd like to simply
continue the current development, so this may be easier to track. But I
don't really mind renaming, of course.


> Having one spec for what is really two devices forked by flags may
> superficially seem simpler and less controversial (everyone gets what
> they want, right?) but it feels bolted on.

Yes, I have the same thoughts.


>> 2. Finding a subset of V4L2, that closely matches the current draft, and
>> restrict everything else. A perfectly reasoned answer for this case will
>> require a lot of work going through all the V4L2 structures I think. And
>> even if we have a concrete plan, it has to be implemented first. I doubt
>> it is possible. Based on the things, that I already know, this is going
>> to be a compromise on security anyway, so we're not happy about that.
>> More on that below.
> To be fair, this could be done on the device side, right? I am not
> saying it would be trivial, but the device implementation could
> restrict the subset of V4L2 it accepts to whatever it feels is "safe"
> and limit the rest.

Hmm, if I understood correctly this means the same thing, as I
suggested, just not including the subset (if it exists) in the spec.
Right? Well, this subset has to be defined somewhere, I think. Otherwise
it would be hard to avoid compatibility problems with the drivers.
Anyway I have a lot of doubts and concerns about this possibility. So
we're not happy with this solution.


>> 3. Stop trying to simply pass the V4L2 UAPI through and focus on making
>> the virtio video spec as close to the V4L2 UAPI as possible, but with
>> the appropriate security model. So that the video device can be extended
>> with a feature flag to something very close to full V4L2 UAPI. A lot of
>> work as well, I think. And this won't allow us to simply link the V4L2
>> UAPI in the spec and therefore reduce its size, which is Alexandre's
>> current goal. So Alexandre and his team are not happy this way probably.
>>
>>   From the security point of view these are our goals from most to less
>> important AFAIU:
>> 1. Make the device secure. If a device is compromised, the whole
>> physical machine is at risk. Complexity is the enemy here. It helps a
>> lot to make the device as straightforward and easy to implement as
>> possible. Therefore it is good to make the spec device/function-centric
>> from this PoV.
>> 2. Ensure, that drivers are also secure at least from user-space side.
>> Maybe from device side too.
>> 3. Implementing secure playback and making sure media doesn't leak. For
>> this case it is nice to have these object UUIDs as buffers.
>>
>> Please correct me if there's something wrong here.
>>
>> When we start looking from this perspective even things like naming
>> video buffer queues "output" for device input and "capture" for device
>> output are problematic. In my experience this naming scheme takes some
>> time and for sure several coding mistakes to get used to. Unfortunately
>> this can't be turned off with some feature flags. In contrast virtio
>> video v6 names these queues "input" and "output". This is perfectly fine
>> if we look from the device side. It is understandable, that Alexandre's
>> list of differences between V4L2 UAPI and the current state of virtio
>> video doesn't include these things. But we have to count them, I think.
>> That's why it takes me so long to make the list. :) So throwing away
>> this simplicity is still going to be a compromise from the security
>> perspective, that we're not happy about.
>>
>> This is mostly because V4L2 UAPI brings a hard dependency on V4L2, its
>> security model, legacy, use-cases, developers, etc. It can be changed
>> over time, but this is a long process because this means changing the
>> Linux UAPI. Also this means, that nothing can be removed from it, only
>> added (if the V4L2 community agrees). For example, we can't simply add a
>> new way of sharing buffers for potential new use-cases once we switch to
>> V4L2 UAPI AFAIU. The V4L2 community can simply reject changes because
>> this is a UAPI after all. We kind of have a weak dependency already,
>> because the only driver implementation is based on V4L2 and we'd like to
>> keep the spec as close to V4L2 as possible, but it is not the same
>> thing. So at the moment it looks like the V4L2 UAPI proposal is not
>> super flexible. Alexandre said, that we can simply not implement some of
>> the ioctls. Well, this definitely doesn't cover all the complexity like
>> the structures and other subtle details.
>>
>> Also adding the feature flags would probably defeat the stated purpose
>> of switching to V4L2 UAPI anyway: the simplicity of the spec and of the
>> V4L2 driver.
>>
>> So I have a lot of doubts about the feasibility of adding feature flags.
>> If Alexandre and his team want the V4L2 UAPI as is, then looks like it
>> is best to simply have two specs:
>> 1. virtio-video for those interested in building from ground up with the
>> security model appropriate for virtualization in mind. This is going to
>> take time and not going to reach feature parity with V4L2 ever I think.
>> I mean some old devices might never get support this way.
>> 2. virtio-v4l2 as a shortcut for those interested in having feature
>> parity with V4L2 fast. Like a compatibility layer. Probably this is
>> going to be used in linux host + linux guest use-cases only. Maybe it
>> gets obsoleted by the first spec in several years for most modern use-ca=
ses.
> This latter device also makes a lot of sense for Android (I know,
> Linux based) where there are nifty implementations of a number of HALs
> that will just work if you assume V4L2 and will not (or will not
> without rework) if you assume anything else.

Yeah, I know. We also have issues with Android HALs. Still we have more
restricted hypervisor and we also believe, that avoiding sharing host
pages is the right thing to do. Because of this moving to V4L2 UAPI
seems to bring us no benefits. So we'd like to continue digging here.
Hopefully with two devices we can be both unblocked. And hopefully at
some point our developments might become useful for you.


Kind regards,
Alexander Gordeev

--
Alexander Gordeev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

Phone: +49 30 60 98 54 0 - 88
Fax: +49 (30) 60 98 54 0 - 99
EMail:alexander.gordeev@opensynergy.com

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

