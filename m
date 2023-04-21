Return-Path: <virtio-dev-return-12345-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A66C7618E
	for <virtio-dev@archiver.kernel.org>; Fri, 21 Apr 2023 16:01:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 138612AEE5
	for <virtio-dev@archiver.kernel.org>; Fri, 21 Apr 2023 16:01:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E2CF1986639
	for <virtio-dev@archiver.kernel.org>; Fri, 21 Apr 2023 16:01:54 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C43F6983FEB; Fri, 21 Apr 2023 16:01:54 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B2D99986636
	for <virtio-dev@lists.oasis-open.org>; Fri, 21 Apr 2023 16:01:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1682092904.364000
X-TM-MAIL-UUID: 5309b300-2b74-4d2d-afd5-59efadf01628
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isFjsgEYQG6mxxGEWxwB34pVQZCReNIowqE4+uL/6LoTpT+5X21r8RNYahszfPRTbMnyC3Cdx9FTLblv5vP17r+dgoW4Xpyw5+VM7Dki+My8TeYwPQPoxaLbtOVMo1jbeIedEtLNgGs2GOcWBsRoT5oNO2duhcIoPNNwdgCrdYiE7LU4WtS2/PnpGG7g8MkC08+NNK0y1iOm0rUxnW7H6jpiNxG+9GlJAt+o8m1FfcmKdZwk+/3KysCk/BZ/0I1TXa0Fez5xnAb/jNqIppVsr86qpVVZLaJXOhlSqwlEEm3f9qU+9VYQI+ZgxOojVmshLi667NRY2EMw1QaR8KiuyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3cTsmEswF9MHMsD7hpdD99m+qcaAQTNDGrRTlyQHq0=;
 b=etOCa0pQlmri0UyLvjRtx1hO7u33hZ+Rx+cRYnHOMyQ6hWwigPYw14S12tqwghFIPdByGHcjWSNYXsdOrxC0LopKFZWTzUxCwd3wo3SXBXr02prtJeK8tt0zHiE3/Ikg0AYyKwjPBG1PQiyz2fN13Gdj7ptJC1GAumpu4iBaJR1W0KtwuPaH12ETmJJ04xRLI0F2K/0Ky9WcfT0XisfxT8R5MbgZplfXcQRzW6csSWjP1+c+O9kld8zey99MQTbMmq5NBwZPgKraYPAnJ55//MMbW+Un1aRSA8rz6A8hJ8dRkYk80yBicGq95s+0CdSqYz/HHmZRFB5vuNy33n8sYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <2d5df33a-c246-81ee-92e7-a44712600e62@opensynergy.com>
Date: Fri, 21 Apr 2023 18:01:41 +0200
Content-Language: en-US
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
 <CAPBb6MUHXh0XYLH=8anWLNQaS+p6_VhMRki+qSqFQGeYQzBSSA@mail.gmail.com>
From: Alexander Gordeev <alexander.gordeev@opensynergy.com>
In-Reply-To: <CAPBb6MUHXh0XYLH=8anWLNQaS+p6_VhMRki+qSqFQGeYQzBSSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE0P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:a::21) To BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:4d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2663:EE_|FR2P281MB1525:EE_
X-MS-Office365-Filtering-Correlation-Id: febd9c11-e09e-4e6b-c2bd-08db4281b348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G1pDz+IFO5BiJPU+J/wfL9xTnY/N98P8NOfW/iUOzJaMwbr1L6TIcun/RQ61BMS4JSHmkw1GMK8f/bhZ9BMKsyRZpLJKwxgDqQhFCUB/EioyxpfloNbKKbBSWdA8XsXRQ+sjc7tGErvYGyoBNUM8MiedGS2OiZ3V4rxfGWU4aKr3gDcE0yjr9nkfNNOLJ9U3Bp83EB6a5EXEvT1I4HtcpmNCA+JQwRFiW+KH1en8K4+ejLyLoGs8PL9g5ulqet44/5efQ8rzH0UIn9WjLtSdP9BWEfqySLWM8GK1MfMWNOlFLAP/Pg+CMnOceotYaC+WAM8msqFeod3AE1/Th5pH/dC8/GaKI7IJh2aoXDqh52xwZgs7nb7L62ng65l2x81T6aMVT7pRF6PspSmDzF0EM++Yd9TDRed3VDV8QbWaXFiwiPbcc9EWe6l7kl+Gy0rR2shcZK62V7k5OIJgeIpbiYbLDkSDcPBxcrCenFlhHcCAV/A2ybQW/cY69rn62HSExwonBnapkyvroEa2+pldIZakf/tTOTiK7b8UkuaZpWA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(39830400003)(366004)(136003)(451199021)(4326008)(54906003)(316002)(6916009)(66476007)(42186006)(66946007)(966005)(66556008)(478600001)(41300700001)(8936002)(5660300002)(8676002)(7416002)(2906002)(44832011)(86362001)(31696002)(15974865002)(36756003)(38100700002)(2616005)(186003)(53546011)(26005)(66574015)(83380400001)(31686004)(66899021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGs5WENENjdDdFAxY1pQU0lxVVFPdG96K2lCOGVkbFE0QjBndUpWb2FBK3p5?=
 =?utf-8?B?VGd3MXZVTUdudWdUeHEzU1lYaVVvU2NBbWdBMENOdmJxTXZLRmV0TC9yZHVF?=
 =?utf-8?B?YjB2WFZZTGVOeDEyRkJNMk9FQnAyWXJ3aFJWeFJHcU4yVkJMSVYxRDAwY2RD?=
 =?utf-8?B?Uno0a2t2b081TVUxclhsRmlLTkNIUFRyWnRvVFcrV2RJdkRuemxocjg2Z0hm?=
 =?utf-8?B?ODAvdURXVFRxZVMyUXZ4UVBHdzUvQ1l4eUJuN2w5RG1PbXRGSTlTWUh2eHpF?=
 =?utf-8?B?UXNsRXVXUk5Xb3c2SGJrOUVMejZTVkFnTlE4QUQrVXJiZ3pTeVJ4RnNXb3ZO?=
 =?utf-8?B?dFRNU0I5K2FaL2o2T3JENDhDS0NtdkNjaGF4MmpGb05vdHRDKzM1alFYOUNW?=
 =?utf-8?B?TFlBY3dBWUhaczVmVkJ6TVhCWitlVkVJeVR6ZXcvejVzSkdiNmh0dmpKa2dJ?=
 =?utf-8?B?QXRJYytqbHE0TmZvWDFFd1grUjZ4RHorNFJaenRuNk1lWU80SlAxUWZnN1gw?=
 =?utf-8?B?djZwd08vdnRSY1l3YXRNVzhjZGFwRXhVbGUrZ3lkL2RsVHZIVXZzNk14cmZw?=
 =?utf-8?B?STV5c09xTHZxUU5YQWk5Vm05cWdZTXM3MkJZbzVCZys3NUt1VkhLa3AyZG8w?=
 =?utf-8?B?Qm9HNVRoVUJjVkVaeitzWSsvY1pYbVp3MHFXTFNOVTJKTHRMRDdOblFrNFYr?=
 =?utf-8?B?cmwxamNKeW9OK0ZjODFtZnFOVUFPZU5TUVNPL3hnUzg4cFZYR3VudkNiSWNw?=
 =?utf-8?B?OFlkQnlvWmw4SEVyZmtzWVRPNlpVd3pDYWZGTGtxWDNBNDhUVmFCNVBqQUJ1?=
 =?utf-8?B?Rkt5eEhaWFA3dzVYcStxUUNrb0NnWi9PNlk5RVBLZ0RaK25BT2JpSGlCajJ3?=
 =?utf-8?B?ZlNESmEvdlpIeDFnanB3WnB0TlF5UW5JUU1tQ25jczZvVitXK09ZRWtCZU5N?=
 =?utf-8?B?bmI2S2F4NWViNEZHRzBpWUdRWjVweWh1eXBFSHNwLzBzQTNkNXRXLytQNUpw?=
 =?utf-8?B?Z1VDRU9RWFRZaVhhRkFaWUE4ZWdGM0FlWmtaVjZSbDBvbTJnSzZ3NW1lSTBB?=
 =?utf-8?B?eDZ3aHpTOFYzMmVpeCs2MXZLdmNiZHgra1ZBbys3S0hzdWlXMVNsUzdHK2Vj?=
 =?utf-8?B?L01jUDFRanl1Y2VOd2ZTT2w3TTZhNFdKa1NhelQxaGFsSkVzV1UzVWEyRjJ0?=
 =?utf-8?B?ekxzY1pvY240YWdxZ2FGbzlwSk1ERUFDSVA1WVA4eVhQWnA0SnBud1o5eGlo?=
 =?utf-8?B?aE1yVUFHWWw4a28raENsV3ExdnhwVHVzTnlSaHVFUVdEbzY4dkZzWjhyZFF6?=
 =?utf-8?B?aEIxSjBZVVluUXQ2QVduVmMxaUxSWTY0SStrOVNmY3pPWC84WmI0US9XQm8v?=
 =?utf-8?B?QzY1RmdxVEVQV2RTclEvYkpBU04wRUt6WlB4RXhrcGJEZVEyZk4yS05ZOWxF?=
 =?utf-8?B?T1lXQ0xHWktJMWdFL3V4eDhNNGRDQ2dKZXZnWi8yKytsR1JSclVDSk9hVjB4?=
 =?utf-8?B?bHVadytiNnZqV2pSZG01czVTOC9tRnREZU1xQ3pGbXh1dmZTb3VVdG1oVEVz?=
 =?utf-8?B?dEx3RGtaaGRtYnlnL3ZkQXF4SE1TdW9XeTU5TzR0M1crMVdieXBHMkVmZ01Z?=
 =?utf-8?B?b0Jrc3V5Q2prb2F6MTcvWWVsRzhCRHdsT004UlBDcjF2T01ZcVhLcGh3RkNT?=
 =?utf-8?B?SitkUzJvK0xCT2ZXbW9qakFGQXdkVWF4YmQzR1Vxanc5L091a3ZHcG1CRUhC?=
 =?utf-8?B?UEE5UGhLVUxyeTQ2dUJveE9sbFZrU2NlQ3A1U0l5NXordGtGdVBoN1llbmFt?=
 =?utf-8?B?dS9NdXhuekJ4QWdJR0ErbnV4NlRPR2lBV0JOMWt4L2RtcDlmcHpJcDdBKzNx?=
 =?utf-8?B?VmprcHF4Zm5UWnhSK2o2NHNFSGR5VVJJbjV2N2RMMTA2aVRrOWdINnFrRC9H?=
 =?utf-8?B?UUlhUmo2aFZQM1Y4MS9kVVV3TllYc09ucXBSNzNVMW1UQ3JtK0d5cVlOa1kr?=
 =?utf-8?B?d3NreUo2OWR3d1k3ckhjdzV2QlR4V0FTNERHOWhCUW5ISVd1QnhmZEQxVC9K?=
 =?utf-8?B?eitlM2ZKTGpSVkxpNmJsQk1BQ1JSU3UzQnpSOGFrUUNQUEtrWWlQbVptNGZ1?=
 =?utf-8?Q?NafnRWUn9cNeDM2alvj00ZiKY?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: febd9c11-e09e-4e6b-c2bd-08db4281b348
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 16:01:43.0706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/D6/UAkOi84SFDKryeNV87j1BmDgdC3pBF5kzhfK95IWDx8SIt9qWlFCKWd0WJWR0LKZnhyUEUzZSTNH6YekQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB1525
X-TM-AS-ERS: 104.47.7.172-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1007-27580.000
X-TMASE-Result: 10--17.218800-4.000000
X-TMASE-MatchedRID: fE0JoqABJp3/9O/B1c/Qy6n9fPsu8s0a9mojSc/N3Qc0C8Dp8kkTtehN
	0jwIx2vHYGK3LJXf9mNkXWktuhCgQvd1SWcwQUIOn6y0mNkW0aQ10wJPYcToKEneIilVX/rqk66
	/gtVjZsXOSDPNwDqJeAD2Qb9HgeXyvxpbh9elAJ0zoDR4ZVO2DOEpCHUsKYYGDO+DX+rUwfaB0u
	KQpVgh2pKBD3/UcK9c/G6bCYxc0QV8rlwYlHLs8eQ0jDxGUAJDbEcBTcmsnmnbkNc8UnHsTZWBi
	0afnA537B3aTRp8ARaV1/ALe+AFBlWUwIAU9VkeZg+ljEMYai7+MnTlbH/dxRHfiujuTbedJ7Yu
	HJjAU1eqfOx/zQXipafhjvbMHGD/mW72mlHeG8PjI0yECAFuKxMTJpTAmTNJ6Z2vNpIov1yjxYy
	RBa/qJQOkBnb8H8GW5MIx11wv+COQZS2ujCtcuA==
X-TMASE-XGENCLOUD: 632e89e9-aa67-405f-a810-b51a3c51d8bb-0-0-200-0
X-TM-Deliver-Signature: 6DF2EC13F1C808939F26C6BCE6B87F9B
X-TM-Addin-Auth: Nrd2cAR6Co759l86Ajy9ELwF4/UqdZ9gWeGqJiAm8DGYJpMqp7cHA976GOB
	Dc3HIrxMuv8WOEZUF3/EhY922t0ClLinsvb9uq6LV8+JnVoghw12Bv0blPg4HjowBytvQNdG2PA
	x8DNAYMd5/BmEfVXIy09jxyhjDItXbwUv4wUXU1qqZKin5k8EZHbnCuupnP45+PlemXCObcSkcw
	5sHVT/9A+c1JS5pB6587xh/oLAnmL4zfRXlZFUxCSDyFwVGAzCnMJmG0DfcLyXwAbB46XKCSr4K
	qlhL/RdjnHIcY1Y=.GSrPmk8QSdUgIcze33VMVU1lqDT8jwyiqF26U51WgaXZGJmrGudnpgtIhA
	IkZOLj/oqGa5OkTKPb82FLLMYTXfSeJTw3IFYUEblx7aJlc22WvZWYw/QtUSQlAAs15cCDqEiQI
	+XQVxykD46jU265/NHHz750tnF0dLciFJIvksXPEVqwI+xaeM/5Jn3KN287V86sb+rRJ5T3knMB
	GpYos8NJap535w1Fta06ZGR+boDzwnQC3c7tX/Q3ojG8Kt/uzyUdJ/WzpHMfA5CQlysL4YKd3Ep
	apzwkmPnScYIP6/VwWNJyGnZpEuP+0P+inX0yC3Vyn/qudjuN/yJYiFmabA==
X-TM-Addin-ProductCode: EMS
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification

Hi Alexandre,

On 21.04.23 06:02, Alexandre Courbot wrote:
> * I am still not convinced that V4L2 is lacking from a security
> perspective. It would take just one valid example to change my mind
> (and no, the way the queues are named is not valid). And btw, if it
> really introduces security issues, then this makes it invalid for
> inclusion in virtio entirely, just not OpSy's hypervisor.

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

Also please read:

https://medium.com/starting-up-security/evidence-of-absence-8148958da092

https://www.schneier.com/essays/archives/1999/11/a_plea_for_simplicit.html


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

