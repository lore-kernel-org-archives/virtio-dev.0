Return-Path: <virtio-dev-return-12440-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E05A9C77B78
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 16:00:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 142A5339B8
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 16:00:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D940098664A
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 16:00:10 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BAFB598662F; Wed, 26 Apr 2023 16:00:10 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A61D8986640
	for <virtio-dev@lists.oasis-open.org>; Wed, 26 Apr 2023 16:00:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1682524807.386000
X-TM-MAIL-UUID: 703bd0b8-a8d8-4ee8-966e-ac85c94e3f16
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JV+YNtA6EtmHYyabBiwI7dH1dcL/cIACNLosPD1YF7PugAmdw3SiCtGC0X1+rdvCxgiKyInbD5PsHOGLauhKiCNQ828bosdrz7sU9XyjDTpyoc0UgybdYD7b2LjskDu3zdvQLE7Xf/RDGPEf+gqRjR1nUi2ggZIYXdiEmxtSneyn3+j9tei2zolTP/KP5/RzIpp60nOhQl/PUzftUATJzV1LprlZ/TVw/k3321dvtwG0LKoC40qsfUzbpCKrQSILK+EVEJwcYyBvptYns0D05CdMf6tafqUEBGtJ+0hBNAOYc9U3IRnlcVvYYJsz4XaJaxrftxo/UwO4VEI4qdoN5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5cB8dtXNB0VjzLucUqNk0tL8meL/ETxHGobGxjrMYQ=;
 b=iC7mVTsARhiB8rbCKPUiGQu7nF8QIhFdP1uq4cOYOWpW8o5HXAnxLgBW6c1DID/5OBAn//z1cahG9DCvYcb/KK0uXhIOlLXlvCiO/ls4px5fvyM/CgwIWv/6B6NufGg4vS6JXhrHlxkXU0QopU8tIRmwl9y3x0AF8B2UhJrGkJhtAEpEpMDNywM6vxo+U8teGQ43+bll64IWn2VGQxtD2X+16cKRh5xKqEV59mGQ0ZdvWH6PrHB1Eg4y23+ntwzX2840yr7bvwnc38yeNDYz4IzkzJbIZu53e4YRoeRBnTisueyVkGb3lTO02lAl3F57HZUkNOdHqVO3ptCk2PgotA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <d83a8f62-a2c8-8f8d-46ed-0d747daca4d3@opensynergy.com>
Date: Wed, 26 Apr 2023 18:00:02 +0200
Content-Language: en-US
To: =?UTF-8?Q?Bart=c5=82omiej_Grzesik?= <bag@semihalf.com>,
 Alexandre Courbot <acourbot@chromium.org>
Cc: Cornelia Huck <cohuck@redhat.com>, virtio-dev@lists.oasis-open.org,
 Keiichi Watanabe <keiichiw@chromium.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Marcin Wojtas <mwojtas@google.com>, =?UTF-8?Q?Matti_M=c3=b6ll?=
 <Matti.Moell@opensynergy.com>,
 Andrew Gazizov <andrew.gazizov@opensynergy.com>,
 Enrico Granata <egranata@google.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Peter Griffin <peter.griffin@linaro.org>, Tomasz Figa <tfiga@chromium.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 Albert Esteve <aesteve@redhat.com>, bgrzesik@google.com,
 "srosek@google.com" <srosek@google.com>, "zyta@google.com"
 <zyta@google.com>, hmazur@google.com, mikrawczyk@google.com
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
 <CALgKJBqKWng508cB_F_uD2fy9EAvQ36rYR3fRb57sFd3ihpUFw@mail.gmail.com>
From: Alexander Gordeev <alexander.gordeev@opensynergy.com>
In-Reply-To: <CALgKJBqKWng508cB_F_uD2fy9EAvQ36rYR3fRb57sFd3ihpUFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE1P281CA0382.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:80::12) To BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:4d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2663:EE_|BEZP281MB2519:EE_
X-MS-Office365-Filtering-Correlation-Id: a0b91268-5dc0-4973-a6b8-08db466f4d8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	711X8kdZQQnrLrgniYqFiF5jd3SZaEsm/TrT546BXLUnCHOklkk05VUxCtfGTJl3L2k6J/O9ZX7UjkEhn4xpMF/jjIdufoyiSiYcg8k6xyiQpfMErJ3blhR4LgZJqslrbe+eLnEFCB08sHUffyAqP6wkmQ6w7CE6gZvEkfDmD+us1U57RlL7AublqhOgetPyLRhJowewqmY0kDykjCKLca7aZ8Tv39upe2DOaTTpgMxRiSg9niiYVqXSSSRqIW+L4erF4iX3lwhB/Wz0e7r31CEC1btqYVdBnFI6jX5gaCxH2R2NrGw5RiYfrfvD7LITbVStjtSYPL0bUUpoFYpNNDVertRcpDtExHXBXi1QEagPdN436YvJSJJVS1t8lIlOAq+f+OD9xD5Q52WsUPNb6RC3HzNQrUkz64BK/4ikrZOV8d6+a5pDzb/F1Ch2O3Uc3IbHvOzrzxUr1FrIVtNftqOWZOXCspPjoe+GEo4C3E4uB5pnr7ZWRRidcn2g8cFnNJM9pMqIsFNzsy51eepRjSpehncMWK6exdIeIh5n90I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39840400004)(396003)(376002)(346002)(451199021)(2906002)(15974865002)(66946007)(66476007)(66556008)(66899021)(44832011)(316002)(4326008)(7416002)(8936002)(8676002)(5660300002)(41300700001)(36756003)(31696002)(86362001)(186003)(26005)(53546011)(478600001)(38100700002)(66574015)(83380400001)(31686004)(2616005)(110136005)(42186006)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmFOQU1TSW9hY1RiUXdqTGVCS0YrR3Fhc0Rwdks4ZTAzU1d2Qzl4TlUrOGZw?=
 =?utf-8?B?Z3E0VzAwdkhYbWdIR0tOcGVvNFdDWnNrVk9KQk5GNFYvQUZ5WUU5aW5KSG5w?=
 =?utf-8?B?eVgrL0RRUFlab3lyejF0Y2ZVNkJ0ZzVUR004NEpmMVBmTnZGOUV2R0ZTNnEy?=
 =?utf-8?B?VzEweGNnemZLTGU4c0ticTIvM1EzZUJKcmZLWTFhd2VYVHJ5SzlkbENSWjht?=
 =?utf-8?B?cmM5dnNlK2gvQU84M2xjYjZnMTg2aDdrcExCaitSNHdzeU55UTNDS2luU2I2?=
 =?utf-8?B?YzdLQWJuRU9VcVowaFZpcnRldXVYZGtUYlFDSlFRbzdjaXZiYkFqcU8yWTZQ?=
 =?utf-8?B?MVFHU1FwZEVlQjg2VmtHMGx3YWdZRGluSDZia2l1MUFtQndOU3NDMFkybnd0?=
 =?utf-8?B?VDNUaitZNHhuc011eXlnUTY2TjVWZGxWN3Y0QWNoZkRNOXdZcFpTREdnVUZU?=
 =?utf-8?B?am5URnhDQ3NocStsWTJuTllpL0JkZ3AvL0s3TmRlSjhCcktmS0NoQWxBTVJR?=
 =?utf-8?B?c2JwTzBOUDRSWGl1UjJaNGZEZEZhdzBwWUwvMWRJMXdvY05LYnhYNDQyOEhw?=
 =?utf-8?B?MHpsMmdHWjk4THRJWVIyZEZZSXlzeElkdk1INS9KRjlqSFBGK0tDSEhvOHlw?=
 =?utf-8?B?cmlZMjNqOWk4VkYydVNUZ1RDOU0vQ0RNYXA0VUIzZGs3aWd4S3JTSlZEbUVn?=
 =?utf-8?B?aXJhQ2VSdUNTM01TNWR0MWlyaFJKU0cvQ21WWVZIUnkxSHFCM1orVmlyV1J1?=
 =?utf-8?B?YW0rdDZERzlKKzdDMGRROXl0ais0bGFXQStsVDdXQWFtSjg5ZGVGVCt0OWh0?=
 =?utf-8?B?UUtlbUI4TDhHRzRFRWNwR3NNNnJkOE8vZXpXU0FvMG5XektJelFuV2p4bUpY?=
 =?utf-8?B?aHByZjR5b2hZZnZZV1JzZHZycDZWM3BMU2pCZlZQNFh6OFZsejFBUmhldzQ4?=
 =?utf-8?B?R1g1Kzc3bnhzUUxZbDgrRGZSbVV0L0dpV0JCcnpueUFOSE1Cb1I4RHdhc2Jy?=
 =?utf-8?B?ZWNINGdyUEJ1Q1kzUG5wcUMzUlhuMjNTaW9hdW1ONzhsOGJaRVFONDQ5cGpJ?=
 =?utf-8?B?REFlSmtJTE5kOFk1dWZZUXRSd2ZmNDVwMk00M3B0U0N1UWI5Yk1pTEhBbWFl?=
 =?utf-8?B?SU5yWG8ycmZnTFhZQ01LZHd2VXo0SmNXSVFOU3ZmR2ZrelZaQjRDcUZBKzJj?=
 =?utf-8?B?SlhnVjRnUmRaQ2ZNSTVqMTU3TndTMG9yVGMxZlJyczZPR0RQVy9ERmxCd3o3?=
 =?utf-8?B?NjFFTkZsd2xCSWVpL0NEbVN3U3NXYTJBbnE0UHlBMVNlYThPcmVNejFxaE5Y?=
 =?utf-8?B?M1JuNlh3N1ltTXkrWW1kNlAxOWgrV21CSEYyRzdNMUZmdHhXcThmcnRmZmVm?=
 =?utf-8?B?WGJRWnZZaFNUZlRmcm9qbm4wRWRVd2JtZUF2OGlrcFJhZHFhUkxkY25iK2NY?=
 =?utf-8?B?S1lPaGJzcEVoOWZXOUs4RHM5YUNuWVc3NjB5Z2VJZnl3bW9tdE1vVDRtV1Br?=
 =?utf-8?B?NlVUUlptYkRMZk9vTGZqZzFuUVRPMk5hc1prSHRSM0lSemRmS1J1czI1Mmhv?=
 =?utf-8?B?RHUrenhRZDhXQ0doL3NWTHdyZk50Y0NwVm1kT0JFRlRERE5qN0VTZ2I1S29O?=
 =?utf-8?B?b21JN0t1OFVWUnFIbWwwbUt5TkthMExRWWJBNHN1SVcrL1NqN2dRZlZ2eHpR?=
 =?utf-8?B?a1ZLSGdDakY1NzNsRUNxSHZBbDVqc1RVblBIaEpOb1BUY1VWeGE4SkNRWldo?=
 =?utf-8?B?c0sycjJFQ1hyODhVenlQV3psRHUrQ3IrNVZkemtGakZaSUhkZlNwWElmK0cx?=
 =?utf-8?B?NWtMS2RhQTJORGRRUDBEam5QNFRoeE40L1kzT1VXMnlERG8rU1lFcTlwMnVk?=
 =?utf-8?B?dFRGbklRdEI2eG5vM2tOWVUySEhiYkNKNDJKV0FwV2tjME5lR1dKUWdwRVNC?=
 =?utf-8?B?djBIMFZYUTBRUDc3MUg3cEtuSDg4VkF4TXVBRmxGdVR3TEMrZS9XMHphaDRB?=
 =?utf-8?B?Rzdwb29xUHkwVlNtSVdPenpnam1kMGdqdHZUU0U1ZmZGQVZ3Mk1XakZhamFz?=
 =?utf-8?B?VjdJTS9qTkw1cG5HemI0WndDV2FSMmc3NFhSUHVSS2FiREttMmRVMmR4WlBN?=
 =?utf-8?Q?kxJZ1TTIavTldxMfR7B7zLk1K?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b91268-5dc0-4973-a6b8-08db466f4d8b
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 16:00:06.1107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQ+aLUqkv+nRRXIWOFECU8K2LqScp4DdGR7aCuTBToscHTB8fniYIZkQJhYoVDccwjHikXiEM2ngoaFtLheI3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2519
X-TM-AS-ERS: 104.47.7.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1007-27590.001
X-TMASE-Result: 10--31.548100-4.000000
X-TMASE-MatchedRID: cxtZ8fwm3r//9O/B1c/Qy6n9fPsu8s0a9mojSc/N3QdlEv6AItKWF0ex
	crp35mDBWxjOUDkI5yCqW4fU4IlE4xzrJSe8bfGqTipLDaMylH0Ex2nnXvzNI0S0FpbI+14TCg4
	+Ouv0RSNV7gosQ1S3r8QXghxVFCP6qwoHAABsrQjwgrvJFY9E0YSkFXHm1a8tw62uSG5kL1b819
	1lvAtzOVSZHlAHrcAQ5YAvdCWT1bBJsyjYmmAr9I61Z+HJnvsOHA5wH3/21xHQv3GMCZUaFuc2M
	U6CoC3kT+8v17QjdI32BVCy1JdixTWs2YGWPbxrOIQ9GP2P2u9PnKxAOPp4WUty8cifGH0UGzEl
	PJ3tb7zY3iIlWCEIE4it1UHFybR1CGqH67UhpHuTeuX4xo2DEBxCcOlDoVfTd2O5KVSlq59rqMM
	R8f2KK3j7z1YNzyvZi/2wY62rdpJjE1dp/+HDNJKIqFdDcBuceLLCA0PD7ahgcShCAFE/pYpMq4
	Bs2PxAjwQarLbSitTQgHOzCONYzEwY9Z3dse9+KM98EMvC2W4xA3W5Uz0j+LOWVZ8NxQmraob/j
	f6TUn3oHOpl9ZcDR1+24nCsUSFNt7DW3B48kkHdB/CxWTRRuyUIayx+Skid
X-TMASE-XGENCLOUD: 994f0214-60ac-4b46-99aa-c88d3bcff63c-0-0-200-0
X-TM-Deliver-Signature: A436CF0B0857545CE12D7C9739D464C1
X-TM-Addin-Auth: UltUe96Q3vHA7aESDIF73yj6fMTph1hZnBct6gxmHpruxVd2C454PINaTEE
	bxexq/MBnRGI3zy4+u43lnn6FcEyJPi3QPpZp9xYsc4H4wucQPnRnV2pSXr9yJY5w4V/SPoR7lf
	6mg4k8lSCy3xZ1iF92Xi9xtDYmWNNAVmdkuKA5vlZf5clFtzkRsEyEJc3/UCakE8ikcnnWUM9Pg
	0xieNAZQkYjOH+EaBr96bQTSKyVGLaxO5JIB2OeVwjut4bKXPb7Ejn5CpPDXJmUyH/S/Lthx+nI
	jvCfFVqcEYjnTJQ=.I4aCV4I2EXqf/8JF8od+SSKyzQ2FykhY6h6atU7rhrYyR4Nv9l3H8sSIBV
	uGeNp0qBbbGOmOeN1VB6S8OBBbegExwlIZ+5zItYSxcodVRgbnCJC43DPM5B8OE2VgeSrI61p6Q
	YJCX/kwQp2fbplxeOnQ4NXwGDmLOVrp/rLviRjL5fWnhtpSCQYVLt+ALTEoWX/l9pHa8g+eXSHV
	LHJHNiQf3Hl/XPqilmZNLAms56cpLjtCvfzbO8anlpWdIQI+f7mDKIzab7aGT+ARNc3VyKh205D
	bGgqLDamnMkAm9L+TkR3Dr8W/HQxSCXlwMtUflszEhZPmMDcjueUmNy6fDw==
X-TM-Addin-ProductCode: EMS
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification

Hi Bart=C5=82omiej,

On 21.04.23 13:49, Bart=C5=82omiej Grzesik wrote:
> +CC chromeos-arc-video-eng team that also works on virtio-video
>
> Hi everyone!
>
>  From the experience of working on virtio-video I can definitely agree
> with Alex Courbot, that moving to virtio-v4l2 will be a great move.
> This move will not only simply things a lot but also allow us things like
> vhost-net like implementation for some devices (however this is
> thinking way ahead and linux only).
>
> One added benefit of this move that I'd like to point out now, that
> probably
> haven't been mentioned before, is moving to asynchronous resource queue
> call. Previously `VIRTIO_VIDEO_CMD_RESOURCE_QUEUE` have been
> synchronous and caused one hard to debug bug caused by this flawed
> design. During the command execution the virtio queue descriptors are
> blocked, potentially leading to dead locking the device. The implementati=
on
> of virtio-v4l2 (even as is - btw nice work Alex!) eliminates this issue
> by moving to asynchronous response of the resource queue (VIDIOC_QBUF).

Thanks for your valuable feedback! Could you please share some details
about the bug? That would be very helpful. I'm working on the next
version of the virtio-video draft, so I can change it there. I like the
idea to use V4L2 as a reference, so we should probably do it like it is
done there, only simpler. Still it would be interesting to know the
details, because we didn't have issues with the current design.

> I also agree that in this case v4l2 would only be a protocol similar to h=
ow
> virtio-video was, that has the benefit of allowing very simple guest
> drivers.

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

