Return-Path: <virtio-dev-return-12645-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201B3C77B7F
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 09:00:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 345A43DF2A
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 09:00:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1026D9865F7
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 09:00:44 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E954F983E4E; Thu, 11 May 2023 09:00:43 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D6E0C9865CE
	for <virtio-dev@lists.oasis-open.org>; Thu, 11 May 2023 09:00:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1683795638.327000
X-TM-MAIL-UUID: b4ae4b89-7149-4c89-acb1-865ffcb6e20e
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJCVemvb0ihtaNRvf6pD82PZAuQ6I6DC0zWmDzZFQogkv7ZlaMUUdr3tLJuR5DIrmbm0NJGsjs0UrfO6uV3bAd+fppUGSlNjXGrubFblVbeIVhtOWh92p+Dz7pf1hhuTX+qliFMX+DgbtnftXSVhUOIfXOStin//p2qY4n/xSX35Mz0YIj6t1cG2Ln8iU3yUFhVQwMQqch90+oVCGHlGUQ+YreTnLHk7lkSNgvQiAsm8PDkeodhJOyHngbJ/82bhOEmQrD3I/5OPRTgk+O63mfOziNXnDGvP5/W8mhN6DLxFOZi7fJBhsFiLcWLMZ69v5kXOtl6XNP3xFUnxq0oO7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIK4LQYjyLn2Uw4evrYkmx6IYLKVEqXVYXh6VP+n/TA=;
 b=AJeUAeqm6Dw/icXzT83LGB7DqjBOwUUs7Mztk5zuW1YtWmaunUAGSf9FwvW0JgElyXePuwMsBlS0aBBdJfF5OQjTuo8fJpuKwQAR8EmN73uqOzjyGME7nbSEcdTjnDxnTlqiphgCPNbakv+C3jkdIKWRCPkATLe6gWOpQ0LqFy3xJBGOOVPGHZ0RW/hyVbESLfaCiXPrL5d7PDXlYV/ZOS17DQ3gPiaIfVKKSQQZukHbAVnV8+DxY+eWwojvj5HW9C9JHj4HXZ5GEEzd/1v3yP9mRA3q9hwt1SJsh45bY9h5xIWQ7gKBcMWLTZWGAbJw8hVwt3P3x80KQPMDga8XqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <624c1712-9a6e-bb10-97ef-71a545534da9@opensynergy.com>
Date: Thu, 11 May 2023 11:00:34 +0200
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
 <87a5ylzf34.fsf@redhat.com>
 <8ee0075c-2604-9fc2-27c0-f68e32e2a923@opensynergy.com>
 <CAPBb6MWePYtAvEzrL2VD7ssjaJfR+JENJp33FbbwQJxxQSqPWQ@mail.gmail.com>
 <c3518814-022d-9c59-7209-5cb236f61176@opensynergy.com>
In-Reply-To: <c3518814-022d-9c59-7209-5cb236f61176@opensynergy.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE1P281CA0323.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:87::8) To BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:4d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2663:EE_|BEZP281MB3064:EE_
X-MS-Office365-Filtering-Correlation-Id: 3baed617-0982-44da-c200-08db51fe2fae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IpRoiO8PAG+hG45ZV9hHVJB1PrXVHoKhCNA//ahv+C4X084P6nwxXs0NC+iZlAfAoHaSc7jsurIrYYuLOEkcxNmJT3aIZpH1lLDQuYjWIIBSFatfrd+IIiorUTSlng75S6x/UMnmIwXM3zenO2/rc/ZSvhM/y1VPsbeKYCWAHAc018jFnYPi73Vnv+R/lu/jDGMwRfU9RrV27O5oD9CBeWFOwzxOC7i0Jy5b4553UPXJPVyehyJsTHtAeVcKB3WHCy9RH6MQe6dtxxga++kGF7mDyC4WwpU5oKcihV1hmtHrMMV860VSdTebx87uMtwfoCYvP205Z3bNEK8qspvzSfsDcEeviZFA1jO1nxSMctXDVCuLFpiKZw4hg84SrVQwKk+w9yGkQlF+x3oUcckBG0ohWpTBr7PxfqMV2cVS26vP/R89gDd71WprIC6atk045eNejejDxyw2qaOYofVGuEQCf3fBjpJWVC+zGWaYgCLhvxfxo56QZlI5AlxsNiD/X1dJ1ozX93OIRIdd5VmP03j5ljoBRBc4pUstYHfxB8Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39840400004)(346002)(366004)(136003)(396003)(376002)(451199021)(38100700002)(15974865002)(186003)(26005)(66574015)(53546011)(2616005)(83380400001)(36756003)(66556008)(66946007)(66476007)(316002)(6916009)(2906002)(4326008)(7416002)(8936002)(31696002)(44832011)(8676002)(41300700001)(5660300002)(31686004)(86362001)(42186006)(54906003)(66899021)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVg1aUcxak9jWnU0S05IRk95V1Q1dlBqY1Npa2hSUXJqTXFmL3ZnRVU2MUw1?=
 =?utf-8?B?Wk45K0QxZzdrUlBkVjBjMGtldW1mc3ZLOHFHakh3Y2RhdUpHNDZaNDFRbXRz?=
 =?utf-8?B?cWQ1bTF1emFndThRYkhpTFlaL0ROMUU1UmZhYTUvaklUR2VaRURIa0RDR1h1?=
 =?utf-8?B?R2RuK2ZPM3NmZ2VEYmsxRGdKOWR2NlJaUkE4MUx6Q29pb1BYaVoxeUJIZnBm?=
 =?utf-8?B?azlQSU5sTzVySzArNHA0UDVnY24xZHhjY3J6NWg4M0kyUGJHZWZuQW9MR0xh?=
 =?utf-8?B?cFVqSVMza0ZBT0dNKzRXblFkUEQrRFBiMHNiS3pvR0hRaGI3SmNiM25HN1Ew?=
 =?utf-8?B?ZVRRMFZienJWSVRaMkF1MCt3Y1I3Wk9WaUNIb0lkbmFTbjJ3cHNDb0RTenJz?=
 =?utf-8?B?L1BwRUZUZTJobWh0ZFRjMDY1SXh3dW1sZWU3R1Y4T002SmxVYUFWYlVDWmJa?=
 =?utf-8?B?dWszYzZrNDRta1lmb05EL3Uvb2tydzB0SXNmUVBRT0l5d3ozaEJUcXZLNU94?=
 =?utf-8?B?SW54MGYyS3VKb1FqMlZBL0dCVmdvaFp6bTFJZmdlNEpuVEV3OXlYVlVIdzZs?=
 =?utf-8?B?WFBZTjU3OTMxNloxenZFR2wrS2lKdUJ5bnlEZ2cvTDVDUW9HZlI4NEVvbmhR?=
 =?utf-8?B?Vkg3WDVDRUZwOUpwQktvcnRlRXFqZ3pjdENBbE45RGI1SktsNFFYck1xT29w?=
 =?utf-8?B?U0c4MmU3LzZCa2JYT24yNmxHeTh1VmlkUGZQYnY4US8ya2czNUxlZWk3alV2?=
 =?utf-8?B?NTZJVTJkSXhvUHhXbzJSanRMYVVJd3RNM2txaG9CNHpqT0dzN1dOKzVhNkJY?=
 =?utf-8?B?SDZhYURDcTJWQ2hpbWV4SktMeDFGaytnUnV2UTVMS2NYOUNWU3dpYVQ1MG9D?=
 =?utf-8?B?ZlpOQ1VhU3VRT2ZPS0FVOG1wUDVCamY0eGtMV1dSR2xmV1RTcld1M0o0ZDMw?=
 =?utf-8?B?SXMwcVhDK3R4d3U3SXFjSmxvc0VWRExKQkFibWR4Ym9vcDR2RUEvcVlsR0Jr?=
 =?utf-8?B?Z1JmeVd4dW1HNUVablk0WUlQNERvb0ZZM2NUWkczejY0WXdKV0dmdVB3OGVP?=
 =?utf-8?B?WWFvbVQ3YlZEWVhiZTFhZ0pYcDhmYlppQUJaYlBqSHoyZTh4d28yeWQ1RVd5?=
 =?utf-8?B?WEZhRkZ5VWs1TlRzSk5SMXQraUZXTEtOOG84d0k3bGd2LzNYL291L3cwc2Ni?=
 =?utf-8?B?RmpiSUVkajNxZk5NcGQvb1p4RDcwbE8xZ3JiSGQ1NENaZjlXdEhGWUI1RUZI?=
 =?utf-8?B?N2dQSXBXbmJpdElUZGw4eGhLRkJCSFFPR0F3UDN5dFV2ZFdqRXBBS2xzbzVj?=
 =?utf-8?B?RjdZVWY5SEpuVlZlSXJ1KzhuSFNhZDhTOVp0b0tEcE9Nb2NFaFpoUThOTHhK?=
 =?utf-8?B?dGhUL21ycU0rSitqcGtEZnhiQkkzYU9RdU8wWHVmQVR2ZzUvZ2svMW5TOXRI?=
 =?utf-8?B?Y0M2cHNjS2RMdm5ncGs5c1UwdzFEWEg2djlwUlBsTlYrcDVBUkszL05XRmtJ?=
 =?utf-8?B?ZFhEd2N2QkNBNE0wYnNzWFYzdGJrUVVKeWxYbmsvYmxtS1ZOa1hWb0h1M0lL?=
 =?utf-8?B?TGhHdWtLZVBOV0RMSlhXOW9oL2hxMGRuVlZ1bG9Ldi9Kbjc5cTlQYVRvVWVo?=
 =?utf-8?B?SUVCS3VyZU01STY4M25HdU05TGRrTXlxbG5SYVNxNW1VZlIzRE56dkpzdW9r?=
 =?utf-8?B?ajh2eEpGV1hiSmdxeDNmZW54d2hqRE43NWtqNFlJM3RyaCtjczcxWFdyeUJH?=
 =?utf-8?B?eE1mRWw5a3loSmNHajNwREdZZnZuencrWm1NbnI0RWxMYnBlRTNZTSswRmx0?=
 =?utf-8?B?aiswenR6QUxBdzBCRGdRWjJkdDIxTDZnZUh6SktvOFR0M2NDVkdaeHYzOWFh?=
 =?utf-8?B?ZE40bFpBaDRSRXA4U1g5REFCeW9HUVZicUpMK25iazFoQXdIQ0N0NWRPOXNu?=
 =?utf-8?B?MmhRSGYvaEdkQnBIYVU2TGhuSGp6aTZMUkVhTC9IVjJGeW14dEhOTUMzS2xx?=
 =?utf-8?B?cGhzcTFWdFJuODVPQktiU0tVR2VlVmtTT1N0NWVNY3pXTEZlOHUybWo2U25G?=
 =?utf-8?B?MVBzNWJaZFhpbVZwNi9tTVhOcGMrRnBlSlFRZ0h6UWRWY1lHUE4vNHZSOEZR?=
 =?utf-8?Q?oNgiw7erjKuheGltGV5/nMSs+?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3baed617-0982-44da-c200-08db51fe2fae
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 09:00:36.8201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wsgEubR5Is+DLhbrJw5wss2L0d9icyVTHrTrYQSPgnIU78va28wyOXT4P3CX1K8YsFc7sJgcjmdeRp8dZhBQyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB3064
X-TM-AS-ERS: 104.47.7.172-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1007-27618.006
X-TMASE-Result: 10--21.116300-4.000000
X-TMASE-MatchedRID: hwsFDxVJcFn/9O/B1c/Qy6n9fPsu8s0a9mojSc/N3QeqvcIF1TcLYLK6
	GmKppGdqLVqxk9o1HBxAKEp+2HkEbv27vtwnQ39AIi5n/oIUxv+/KQGKQH1rQFAoBBK61BhcGDr
	P8zNo4TwMf7Ce+LIFds5yw/YC8uhnp1reWSY5Jcf0hv/rD7WVZKPLTdfaE15XQmw1cPfvj6maY/
	lzalOje6e76VC6sRoK8uypKo/12dOrofp7IohGwyhvVjkRcuKhAajW+EL+laOtBiS9hFeaTOfE4
	NGuUaNHfWrgQNsTIWqUI512D01p9G7lkbyMKxttFDuTLTe6zcMR5c83KIxTTjjG1ABBh6LlUYh+
	XbvSa0glqqWTemaW5INFhuChNKBZJBgtEIxUn4FOKksNozKUfTa6AaQm7fhmN2zK9lb+laYJtgc
	1847JRWrffv7+FREl3CoThJDYrJ3vXN3A3XXzVAqfFInLO1+qufh9X6Nby0dLgo8+IIHbcDF4uf
	kENdZYq5p0FO1cy3UiMVQeM1VSM202TQpj95Hq0oNxPV/0KMSV3TRDlI7Srhdidqgv9+A7kCPMG
	zqmoXtKkAU17gNQngsSh9atRkcwXz51KoqDPz92GSKUJKO/tQ1bi9r2Kq3eSJHw5DazHabMoAJf
	sjm0Topc8cdcOaXD7icOXRyDqapLuEQOcnWva0R0oIwoMPyV2AtQU7c1a/eckOuhl70pQzKF9Ob
	UarRIOsgEj+Ozwd5og+vDn4uoN5cFdomgH0lngxsfzkNRlfKTzVw79BoLWCXVtBmyOiKujoczmu
	oPCq2UTGVAhB5EbQ==
X-TMASE-XGENCLOUD: c9f5489d-fc3d-41a3-a80e-c31196184df4-0-0-200-0
X-TM-Deliver-Signature: 660C227EF3E4F22DF9B8D8BBDCD8AF12
X-TM-Addin-Auth: U/eZmrBcS6fqg5FAbTu5q1Cm8f0mBMwYZJkA09upAozOi5fhUG/cT752E39
	SG2aqdhlGQgSo7JT1GUKZrpIOCT2bH1R05gnH1Bk81MlkEpWvlKQv/0reIhGW+lmmAXBRHyZAPD
	zOg/hvHzc4EUN6MNkCEvN9JDBndf9+E9RzQpNq2vQ5a6rYujgNvgMjnAKnpvUSpvKETK3xCKGpM
	crGO6GaIjV5Zfq8LM3muHu9jAfIDT+c5YYwfX1X162x9a8ukZT2Jkqg4FBXn5ALXFPH+SKEE0al
	tnTxQcPP0R8JYUU=.0EoaMHD/iXlKSSSr8GCoSCaBHSdb4pF8DzDpXVt/+jVGn6Odm4hvbqZwMq
	XSSn2o0xla42PkQ4zV3uajpRHVz57LkBU1Ngib3cEQqxb2qDsPL4PJkZku4cL1nrYIv+CYhx4o4
	PiwOpConuVtaRPur/EtjVXBa0RUgEXR+b2+6YLbhegzhqEvbMyWK/wfiblA+WRDAfPWthlJDKvU
	2a7vxiMvC3CjiwyfxFgIRIIv3KdxrquyCosxeiU+qH8u+TTr4DWTpwZu6ph4Xyecxpu3F8FBKKk
	mY9yYcR6ouCxtVQvKLMx+L+YDT0ChkqromLutQ7qlEL+GVojpqT0v2o01dw==
X-TM-Addin-ProductCode: EMS
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification

On 11.05.23 10:50, Alexander Gordeev wrote:
> On 08.05.23 06:55, Alexandre Courbot wrote:
>> On Fri, May 5, 2023 at 8:55=E2=80=AFPM Alexander Gordeev
>> <alexander.gordeev@opensynergy.com> wrote:
>>>
>>> On 03.05.23 16:04, Cornelia Huck wrote:
>>>> On Fri, Apr 28 2023, Alexander Gordeev
>>>> <alexander.gordeev@opensynergy.com> wrote:
>>>>
>>>>> On 27.04.23 15:16, Alexandre Courbot wrote:
>>>>>> But in any case, that's irrelevant to the guest-host interface, and =
I
>>>>>> think a big part of the disagreement stems from the misconception
>>>>>> that
>>>>>> V4L2 absolutely needs to be used on either the guest or the host,
>>>>>> which is absolutely not the case.
>>>>>
>>>>> I understand this, of course. I'm arguing, that it is harder to
>>>>> implement it, get it straight and then maintain it over years. Also i=
t
>>>>> brings limitations, that sometimes can be workarounded in the virtio
>>>>> spec, but this always comes at a cost of decreased readability and
>>>>> increased complexity. Overall it looks clearly as a downgrade compare=
d
>>>>> to virtio-video for our use-case. And I believe it would be the
>>>>> same for
>>>>> every developer, that has to actually implement the spec, not just do
>>>>> the pass through. So if we think of V4L2 UAPI pass through as a
>>>>> compatibility device (which I believe it is), then it is fine to have
>>>>> both and keep improving the virtio-video, including taking the best
>>>>> ideas from the V4L2 and overall using it as a reference to make
>>>>> writing
>>>>> the driver simpler.
>>>>
>>>> Let me jump in here and ask another question:
>>>>
>>>> Imagine that, some years in the future, somebody wants to add a virtio
>>>> device for handling video encoding/decoding to their hypervisor.
>>>>
>>>> Option 1: There are different devices to chose from. How is the person
>>>> implementing this supposed to pick a device? They might have a narrow
>>>> use case, where it is clear which of the devices is the one that
>>>> needs to
>>>> be supported; but they also might have multiple, diverse use cases, an=
d
>>>> end up needing to implement all of the devices.
>>>
>>> I think in this case virtio-v4l2 should be used as a compatibility
>>> device exclusively. This means discouraging increasing its complexity
>>> even more with more patches in the spec. virtio-video should eventually
>>> cover all the use-cases of V4L2, so I think it is reasonable to use it
>>> in both complex use-cases and in simple use-cases, where there is no
>>> decoder/encoder V4L2 device on the host.
>>>
>>>> Option 2: There is one device with various optional features. The
>>>> person
>>>> implementing this can start off with a certain subset of features
>>>> depending on their expected use cases, and add to it later, if needed;
>>>> but the upfront complexity might be too high for specialized use cases=
.
>>
>> I don't see that many negociable features we can provide for a
>> decoder/encoder device - at least not many that are not considered
>> basic (like guest buffers). In terms of provided features for codecs
>> virtio-video and virtio-v4l2 are essentially equivalent.
>
> Actually I see a lot of potential in using the virtio feature flag
> negotiation for virtio-video:
>
> 1. We already have some feature flags related to memory management.
>
> 2. I think it would be great to take V4L2 controls negotiation and turn
> it into the feature flags negotiation. I really like this idea and I'd
> like to implement it. Not all the controls at once, of course. Still it
> would be very easy to port more given the existing process. They
> correspond well enough to each other, I think. This way we don't need to
> introduce something like the VIDIOC_QUERYCTRL/VIDIOC_QUERY_EXT_CTRL, we
> don't need two mechanisms for feature negotiations (like it would be
> with virtio-v4l2, right?), also all the features would be in one place.
> Then we can directly reference some enums from V4L2, like
> v4l2_mpeg_video_h264_profile or v4l2_mpeg_video_h264_level. That's what
> I call taking the best from V4L2.
>
> 3. We can have things, that V4L2 doesn't support in their stateful UAPI.
> For example, dequeuing output buffers in decoder order.

I'd like to also share my current roadmap for the draft v7 of
virtio-video (or maybe the draft v8 in some cases). The significant
changes would be:

1. Making querying the capabilities fully compatible with V4L2 but in 1
round-trip over virtio, not 10+. This is what I'm actively working on
right now.
2. Making all the commands non-blocking by providing completion events
over the event queue.
3. Adding back the controls from v5 and adding the corresponding feature
flags as I wrote in the quote above.

Also I'll address all the other comments, of course.

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

