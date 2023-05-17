Return-Path: <virtio-dev-return-12746-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CF8C77B7A
	for <virtio-dev@archiver.kernel.org>; Wed, 17 May 2023 07:35:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6069F1462C9
	for <virtio-dev@archiver.kernel.org>; Wed, 17 May 2023 07:35:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 466889865B5
	for <virtio-dev@archiver.kernel.org>; Wed, 17 May 2023 07:35:37 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2BA84986319; Wed, 17 May 2023 07:35:37 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1896A98632A
	for <virtio-dev@lists.oasis-open.org>; Wed, 17 May 2023 07:35:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1684308933.778000
X-TM-MAIL-UUID: 70f5acad-abe5-43db-bc2e-3d0ae60ebe0f
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g75O9f06rJ/aM61DGAmmLavZuH9SnPQLHkTLhXwlo/1Q0E4C2XDGKxb62/WEZDumQlJF1PK42zY1qCw6zmo+CAT8k1WU6WreNzv7y4UIuUnwS6sj++o5OOXDoYMHkQ0O1m0/Lxm2jCLfww3tpo52+rbde8dC50VKq7rfYXxjC0gM0kt6dyjltdBmSMtbQvLEHSAzXnENY+cbSzE5saONmNIpBLBCrDhTYizHq2VtGlRIPDCCMDC4VnPV5q1O6J7O93LAK/ZEQnGIiBu3aioQ2kZy1nMkbFKVuB51kDVfY/hM79LbUI5NFS1iKXTtlEMcJqEZYyryFq/BJFgqkIWryA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynXv9lGoB9Ex3wo4nbadREirP85XjLLyXM/EQ3WXZLU=;
 b=dRVGlMFT0XshVBYQphbQEdCfE4KqIC+S33UyuRwqnOJDLxKyQKysK1A4vyW0+Hu5xUBC+Bs0gfOa0l3r2AVPCxNvbNUk82t5dJT9O+ozRb/zvBJc1xoDT+pPVESYjSVltzEhQws/ZFepHzyZ8+qHKBHUeJLLLdsU2xlQnuEO5tfFSQldsgCIWOBv9udxg3XnjagqjV5oRlB/cTi8wzd62h3ve+TwaoIf0Sjkvsm5FuNL1C+crQ4dc1t5bLfwpTysEyuwhm6tMw577alpT1onK3uaYDXuZUsebhOcRPqLVqE1TMzZe06DjFxg7U7VaOX8beuvqLuiD2MWnSf+cYrXbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <eec3fb30-0208-d26d-5715-5700979cfdb1@opensynergy.com>
Date: Wed, 17 May 2023 09:35:28 +0200
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
 <624c1712-9a6e-bb10-97ef-71a545534da9@opensynergy.com>
 <CAPBb6MXw5PebCXYBvXOP_b2j+t-1Y_rSJv7kWkLPsa3X+uM9gA@mail.gmail.com>
From: Alexander Gordeev <alexander.gordeev@opensynergy.com>
In-Reply-To: <CAPBb6MXw5PebCXYBvXOP_b2j+t-1Y_rSJv7kWkLPsa3X+uM9gA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE1P281CA0231.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8c::12) To BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:4d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2663:EE_|FR0P281MB2352:EE_
X-MS-Office365-Filtering-Correlation-Id: afceb5ac-cca1-4ec6-6e86-08db56a94b9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ks1Oo3b6vJuZlQ9o54JFPTmCNiZmHl3gFd56BLHRCpnMtmBZ/hR94JL5AsrENE8rq+SyXfsv1MSU9xGWPo+1C55ZWV3FCwO2Y23N/Y6/M/P1bBcCMkY4cRhFuTxvSvxeLnfa2GD6gRZuM+rQoSypPet8R+zWOBBGaZLvmvNwhAZzhkIyOHfS3+ZteBjJ6o95Eg9GihvP2ZZY0GDBpbcqJ2ccY/gju0qSpD5rpy4z3Mw2JYMZ8cGAQlz5jnYWuuafBjlL6O9FhYjwG06GlTe3FMOu4ayVDSQlyK7yC4FgNpXSDI5/RUeX6s1Dw+qcgYZ7S3De8Kjr4Wu5viHbTjhAXOg8sPrOEQ5iiaSxgoM7rUK74QvrGsEggG+qRvdelKlIDbJ/0mkDSpm3Hv74Fd0rVXu6BCfuKn74AtfT9NHofIAX+YQZcQl1brcz8xzSAiYTXIr7ebAmWSJxucRRu+M/cw2QcP39bPJ/FX1uuXe8AEtXwGFKLCGACVX6nTtm/ppXcGzDI985/PyE2K8Qx0MmQJTBvYx+lx+1ZYm8S1+O/os=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(39850400004)(136003)(396003)(451199021)(36756003)(31696002)(86362001)(15974865002)(54906003)(42186006)(316002)(4326008)(66946007)(66556008)(66476007)(6916009)(478600001)(8936002)(8676002)(5660300002)(41300700001)(2906002)(7416002)(44832011)(38100700002)(2616005)(26005)(186003)(53546011)(83380400001)(66574015)(66899021)(31686004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2dXWFV1Um8rck1wcmF5ZzVneTMxMVdmNEMwaGQ2bEZQOW9hT2J5VmVBNzRs?=
 =?utf-8?B?Y1FNUFpiSEVmVlE4UXg5d0JHQjVNYm9uUG1kbW0vL3FUQ3BHOVZYc25sRVFk?=
 =?utf-8?B?TFJydUpya0lZeWExV3JWVWw5L3BObXFpajNCOHVyemljeFNBaVUrdG94RkV4?=
 =?utf-8?B?ZE5YUHRIZm81aEFxY29yRDBacmJpTVQzaWxMclgwK0hYeG9YZHJoTEs3eFp5?=
 =?utf-8?B?WG5ZcXU2akZqcm93M3JmQk5IOGhPcWNDa3RQcWR4MzQ3cmcxSHJaVVh3R0lr?=
 =?utf-8?B?Z1Fma2MxcThiZHRrQ0VMdmM3MnNyOTlleFFQWUJ6NlVSMk55S2E0RUNISEwv?=
 =?utf-8?B?VGMvalBIUlNuaE50bnFMcFozbituZWdpajFrL1JZeHppTklEQWNTc25aT1dI?=
 =?utf-8?B?UnpVdFpabzJWb2p0NkVsUkR2RHJ0cVVMQ3BCMmRVdFJtKzNPdzBMd1hvSjRq?=
 =?utf-8?B?a0pvRUNBeGRiVkQ1WTVoUXgrS0FpMGRVRUQvN0RySkZFdDVPdFVEVTJRR0hw?=
 =?utf-8?B?M21WM0p4YS9odDhJcVhsQW90TDVZYjFOTERSSkFsWXVzMHBBUy94eTVzd3JO?=
 =?utf-8?B?NnhYdE9YeVpKbi9UM3NZbUxnR2NmRVlGUHpSVzhaT0RmeENKT1pqUEdwT2Rl?=
 =?utf-8?B?UWtqMlhwVldnd0FobElpeDR0NXFBQXZPUDlIS0FnVW9NNWlRSTJpU1pUT050?=
 =?utf-8?B?aXYxbVprV25xSG80N1lieCs5Q3pUVlRZeWpoeFdPWDY2bHF0em1wT3QwcGla?=
 =?utf-8?B?aDc5WStCcmowekZBR2tGT3dwQTJsR3QvY0dmbmlVQjhMQitKemhzRVh3dllF?=
 =?utf-8?B?b0I3bVJjWk9WM0U0ajRqR1BpUk9zWUpxdmJJVHNwcCtSUjhoQjFqcDNFRWVj?=
 =?utf-8?B?SjhmQ1VZUytvaHdBRFBaMHB1ZitoTmtpU0xzS1dvd09WK3FTUEg3YXhTYlJB?=
 =?utf-8?B?bFhDYS84bnFSSW5QYTRYOTdQRElTdEdmakRHb2daNmQ3VjF3c3lJZk95WEZ5?=
 =?utf-8?B?NGVDdE40d3FzbStGSEhkdmV1cDVwVFpRWFNwQWdNcXFocW5WNFdRMG96aEZX?=
 =?utf-8?B?OUtQQjNtbmFKQlYxcFJiQ1FvRkhZQXd1S1pHNENIQUlUZVdRbiszNjVrSnhO?=
 =?utf-8?B?bGJQQ0FzUUJDU1FpbEpvWWpYaEg1Uks3M0U3dGdUc0JQY1NWMU9CcThEZlF4?=
 =?utf-8?B?TExqOGNPSVZqUVJrajZsa1FhTUdraTFTSWVoTGxvdStiZk1keEtYUzgvcFEr?=
 =?utf-8?B?NEpMV2h0S2x1ZUZKVjFRQjNOU0RqNmNPaXBkaXpIZm0vdWNqTUFRN3BSV01i?=
 =?utf-8?B?WUk2aFNxS1BwUGNQbHNuemY4NmRpLzJxLzZEOEV0elB6UDhEL3JYbExGWUI0?=
 =?utf-8?B?QnQ3UVUzZU5aZ1NCWmpqN1NaZVJlUjBIYzBqMUJwQzJ6RnljcU9yZnNTYnJp?=
 =?utf-8?B?NVorQ3J5aFRHN0N5U1pKOEltVE42QWc0MGJDVUk5dHVRMklNb1JOd2t3elVS?=
 =?utf-8?B?TTV2RzdTaWk5ZjBib3FBMlk3eVhOcWRKUWdMMyt5RkxMVHo0VFFRbHdqRFdz?=
 =?utf-8?B?SE1NMm0xcHRlSWlub1N5U2R2T3o1ODRWek16dEE5ZlowekdpV2h1ZDVkOXpt?=
 =?utf-8?B?d09Ybm54K3BVbWNkSHlBY0RYaGRrelpiWlpHUFpxVWxVeEJGSlNOa0FPaFFD?=
 =?utf-8?B?dGxFTmZ6K25VTzRmOVo0aklEdUpHQnJ2SzR3bWdxK2NFUlBsK0sweTVxTUFC?=
 =?utf-8?B?OE9tS1FuTDYxZ21WZEQ4WG5tWVlrcURndnpjdExFRnRmWDZjWVMzdjZrN012?=
 =?utf-8?B?MXgvRVo5aVMwK29oazFENTFUUGF3RUFGT3JGNm0vRWdjenorLzhneXpUT28v?=
 =?utf-8?B?VFlJOXo3bDhyOHFhWVEweEk1OWF6S1I3TUdRV1hHdkxjbURCUVlNS0xNbVFh?=
 =?utf-8?B?ZEJJeEVyT0p3MXlMc1hCdkFVbjczUGNSZTFVYStYYi8yWWgxQUQ0cVdNdS9H?=
 =?utf-8?B?eEJlT2ovNDNtU1hwY20rVUNWWFNVZFc0SU51blNTbVVzaUE5c0QxTUthUjZB?=
 =?utf-8?B?clRDVFgzSy8wRW8vWkFZL3pmL2gxcE1mTnlob2VDeDBxenJycWR2ZDVKcFU1?=
 =?utf-8?Q?CyMQIcmrJm7rYLfVfleQQoVKV?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afceb5ac-cca1-4ec6-6e86-08db56a94b9c
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 07:35:32.3821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5VdlByahkyQwW7bwMn9j8B+M+DgPkh1LmfCxQo7FTp1pVOlSAHKxmZgW37AX3OJxUP8JkPPYS6YUZ9/x8L5zeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB2352
X-TM-AS-ERS: 104.47.11.176-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1007-27630.005
X-TMASE-Result: 10--26.889200-4.000000
X-TMASE-MatchedRID: IeZYkn8zfFr/9O/B1c/Qy6n9fPsu8s0a9mojSc/N3QeqvcIF1TcLYLK6
	GmKppGdqLVqxk9o1HBxAKEp+2HkEbv27vtwnQ39AIi5n/oIUxv+/KQGKQH1rQFAoBBK61BhcGDr
	P8zNo4TwMf7Ce+LIFds5yw/YC8uhnp1reWSY5Jcf0hv/rD7WVZKPLTdfaE15XQmw1cPfvj6maY/
	lzalOje6e76VC6sRoK8uypKo/12dOrofp7IohGwyhvVjkRcuKhAajW+EL+laOtBiS9hFeaTOfE4
	NGuUaNHfWrgQNsTIWqUI512D01p9G7lkbyMKxttFDuTLTe6zcMR5c83KIxTTjjG1ABBh6LlUYh+
	XbvSa0glqqWTemaW5INFhuChNKBZJBgtEIxUn4FOKksNozKUfTa6AaQm7fhmN2zK9lb+laYJtgc
	1847JRWrffv7+FREl3CoThJDYrJ3vXN3A3XXzVAqfFInLO1+qufh9X6Nby0dLgo8+IIHbcDF4uf
	kENdZYZ6kRU0tXp7+frNle5ke4nzQbcGPY644u8IK7yRWPRNHjLrHqvAiSy3jyHMch8kOw5aE0p
	i4zt424fRLMfglY9lnKnQM55P+q+wOdDq3DYSFsWedgrJMQ/joSfZud5+GgEbdRL8jlwNHerq51
	yqZP3JBze/7xX8D+bN/5p6gxq5S879CqFHRq25N65fjGjYMQHEJw6UOhV9N3Y7kpVKWrn2uowxH
	x/YorePvPVg3PK9mL/bBjrat2kmMTV2n/4cM0koioV0NwG5zrQvuXKii3YxHfiujuTbedJ7YuHJ
	jAU1eqfOx/zQXipafhjvbMHGD/mW72mlHeG8N+yskgwrfsC30tCKdnhB581B0Hk1Q1KyJHtBsf5
	/UXJbVQu1GNZ+sikGUtrowrXLg=
X-TMASE-XGENCLOUD: 2f303da3-224b-48c8-8016-91b62679fe9e-0-0-200-0
X-TM-Deliver-Signature: 404A25A97D50B7ECA02D711D33B2D8A7
X-TM-Addin-Auth: HUfnBZxIGugCaTqQLVeeDbsXTMBGRy8WZrAgQ24WkH1lbXUNYmL2czalqnJ
	58pVQWJGvee6DaheyRY9opVRrrMCgrAX0rHX6wj5p3KxlGMPfBU+28317CjeaNQR/XCuD0C56ay
	h6kXwzJ3jfbIkYKkS530EGygbiF7uWeIrUxWlezbSyOcfsD7g0BX/Bt5Bg0Uv6Ks4vZ4sOvm0s8
	pmESmKpdhXiBiN4Yz2M6tQoJvpbyco2v0mgvHnjbbmHWhxK+lWG1v1vOFRDPmU7qYc4RdEQ3Sq+
	SIQYaGWNscjAapE=.uu9mfqzAFLL2n0GSsdPd18Zd8aagvsTDUKNfmuZ36sn9S5aJxhP+t+UC22
	Er4/TQrxpUYvovd6d0b46aaBftWo73PxgQkGKew3OB2hZqrWB8D3N3xITEkjfkKCNHatLJaRFMr
	Qht5i6uM7vWFCFhupwvuoE2JntY1uekBtmdzaAJQ+BfNZ2Atic4svfldLQ4MfXQEUvdhtE0lW0Y
	kSaKYys17pPYPHZ0BFzp87WWlc+IY8V+uCQ2PnF/a00AUQT9GCpVNQeguIeG5zULgtFBE4FrTsK
	u3ysFguLPROfe1rvs1h7Utp+RACcpt3S911uvrbQJvEWEJV7vOnlABfBfYg==
X-TM-Addin-ProductCode: EMS
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification

On 12.05.23 06:15, Alexandre Courbot wrote:
> On Thu, May 11, 2023 at 6:00=E2=80=AFPM Alexander Gordeev
> <alexander.gordeev@opensynergy.com> wrote:
>>
>> On 11.05.23 10:50, Alexander Gordeev wrote:
>>> On 08.05.23 06:55, Alexandre Courbot wrote:
>>>> On Fri, May 5, 2023 at 8:55=E2=80=AFPM Alexander Gordeev
>>>> <alexander.gordeev@opensynergy.com> wrote:
>>>>>
>>>>> On 03.05.23 16:04, Cornelia Huck wrote:
>>>>>> On Fri, Apr 28 2023, Alexander Gordeev
>>>>>> <alexander.gordeev@opensynergy.com> wrote:
>>>>>>
>>>>>>> On 27.04.23 15:16, Alexandre Courbot wrote:
>>>>>>>> But in any case, that's irrelevant to the guest-host interface, an=
d I
>>>>>>>> think a big part of the disagreement stems from the misconception
>>>>>>>> that
>>>>>>>> V4L2 absolutely needs to be used on either the guest or the host,
>>>>>>>> which is absolutely not the case.
>>>>>>>
>>>>>>> I understand this, of course. I'm arguing, that it is harder to
>>>>>>> implement it, get it straight and then maintain it over years. Also=
 it
>>>>>>> brings limitations, that sometimes can be workarounded in the virti=
o
>>>>>>> spec, but this always comes at a cost of decreased readability and
>>>>>>> increased complexity. Overall it looks clearly as a downgrade compa=
red
>>>>>>> to virtio-video for our use-case. And I believe it would be the
>>>>>>> same for
>>>>>>> every developer, that has to actually implement the spec, not just =
do
>>>>>>> the pass through. So if we think of V4L2 UAPI pass through as a
>>>>>>> compatibility device (which I believe it is), then it is fine to ha=
ve
>>>>>>> both and keep improving the virtio-video, including taking the best
>>>>>>> ideas from the V4L2 and overall using it as a reference to make
>>>>>>> writing
>>>>>>> the driver simpler.
>>>>>>
>>>>>> Let me jump in here and ask another question:
>>>>>>
>>>>>> Imagine that, some years in the future, somebody wants to add a virt=
io
>>>>>> device for handling video encoding/decoding to their hypervisor.
>>>>>>
>>>>>> Option 1: There are different devices to chose from. How is the pers=
on
>>>>>> implementing this supposed to pick a device? They might have a narro=
w
>>>>>> use case, where it is clear which of the devices is the one that
>>>>>> needs to
>>>>>> be supported; but they also might have multiple, diverse use cases, =
and
>>>>>> end up needing to implement all of the devices.
>>>>>
>>>>> I think in this case virtio-v4l2 should be used as a compatibility
>>>>> device exclusively. This means discouraging increasing its complexity
>>>>> even more with more patches in the spec. virtio-video should eventual=
ly
>>>>> cover all the use-cases of V4L2, so I think it is reasonable to use i=
t
>>>>> in both complex use-cases and in simple use-cases, where there is no
>>>>> decoder/encoder V4L2 device on the host.
>>>>>
>>>>>> Option 2: There is one device with various optional features. The
>>>>>> person
>>>>>> implementing this can start off with a certain subset of features
>>>>>> depending on their expected use cases, and add to it later, if neede=
d;
>>>>>> but the upfront complexity might be too high for specialized use cas=
es.
>>>>
>>>> I don't see that many negociable features we can provide for a
>>>> decoder/encoder device - at least not many that are not considered
>>>> basic (like guest buffers). In terms of provided features for codecs
>>>> virtio-video and virtio-v4l2 are essentially equivalent.
>>>
>>> Actually I see a lot of potential in using the virtio feature flag
>>> negotiation for virtio-video:
>>>
>>> 1. We already have some feature flags related to memory management.
>>>
>>> 2. I think it would be great to take V4L2 controls negotiation and turn
>>> it into the feature flags negotiation. I really like this idea and I'd
>>> like to implement it. Not all the controls at once, of course. Still it
>>> would be very easy to port more given the existing process. They
>>> correspond well enough to each other, I think. This way we don't need t=
o
>>> introduce something like the VIDIOC_QUERYCTRL/VIDIOC_QUERY_EXT_CTRL, we
>>> don't need two mechanisms for feature negotiations (like it would be
>>> with virtio-v4l2, right?), also all the features would be in one place.
>>> Then we can directly reference some enums from V4L2, like
>>> v4l2_mpeg_video_h264_profile or v4l2_mpeg_video_h264_level. That's what
>>> I call taking the best from V4L2.
>>>
>>> 3. We can have things, that V4L2 doesn't support in their stateful UAPI=
.
>>> For example, dequeuing output buffers in decoder order.
>>
>> I'd like to also share my current roadmap for the draft v7 of
>> virtio-video (or maybe the draft v8 in some cases). The significant
>> changes would be:
>>
>> 1. Making querying the capabilities fully compatible with V4L2 but in 1
>> round-trip over virtio, not 10+. This is what I'm actively working on
>> right now.
>
> That sounds good, while not essential since the capability negotiation
> occurs before we start streaming so these extra trips should not be
> perceptible by the user. But the current capability command was not
> suitable and needs to be improved anyway.

Great!
Well, there are a lot of steps in capability negotiations in V4L2:
1. enumeration of coded formats,
2. setting the coded format on OUTPUT/CAPTURE,
3. enumeration of raw formats,
4. enumeration of resolutions.
5. enumeration of intervals (optional),
6. enumeration of controls and their ranges (if the range is a menu, it
needs its own enumeration).

Each enumeration is 1 API call per element + 1 more in the end. So it
may require up to like 200 round trips overall if there are many
controls I guess. I believe only the first step can be done before any
streams are created. Well, maybe one can create a fake stream and do all
the enumerations during the startup.
Right now it doesn't look like a big problem. If somebody tries to run
the video processing over a local network, they may notice the startup
delay already. Please correct me if I'm wrong.

>> 2. Making all the commands non-blocking by providing completion events
>> over the event queue.
>
> +1 on that too, as the experience with virtio-v4l2 suggests this
> eliminates some headaches down the line.

Super!

>> 3. Adding back the controls from v5 and adding the corresponding feature
>> flags as I wrote in the quote above.
>
> Beware of not repeating the same mistake as v5 (all controls under one
> big structure). If you mean extending the parameters mechanisms with
> the things that are missing from v5, then yes that should be done
> anyway.

Thanks, noted.

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

