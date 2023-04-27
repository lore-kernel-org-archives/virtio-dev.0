Return-Path: <virtio-dev-return-12452-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797B8C77B61
	for <virtio-dev@archiver.kernel.org>; Thu, 27 Apr 2023 14:35:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B0CB82A8EC
	for <virtio-dev@archiver.kernel.org>; Thu, 27 Apr 2023 14:35:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7A9D5986653
	for <virtio-dev@archiver.kernel.org>; Thu, 27 Apr 2023 14:35:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5CA99986644; Thu, 27 Apr 2023 14:35:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C3633986646
	for <virtio-dev@lists.oasis-open.org>; Thu, 27 Apr 2023 14:35:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1682606098.618000
X-TM-MAIL-UUID: b218e146-5af1-49ca-a080-326b18142a9f
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkHKYRK23RKyrkrLx1sMzkCoqyR0ha9wgP76Z5P3Si3TFQii0PcWSA/hLz6KrLX8ZSfHcm62763eIjN+e6OQIAeGaoEBlXsLXasM/es2vDHVRvw+DHjekDokg2+Tn7OOVlg6q7uaGqUQ5g6RTmtckcl6OlwIK21FPH7E7jpeK1vB1i7rxdA06Suk1ZarynKQz1Vgn6q32A3NQr/6SmNw5jAESOxMIcWhKKVj0f82wgJScTYXUHjTOu8vdjOnbtWDR3JUj35t7UwplJjtkdGJ7DKwjNrBMr0NNSpHqi3r/6KcOcrrjxABxNEutnbYeRWNIQni6mwcV98dul2gsfMNOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAVuJmVGUCMYbwx2UxYwnVAV7MpBJ0ML3aXFf/UUfjs=;
 b=cCskSohYiY29P44eCb1LKxSy6nqrbIgNxIldvJuTvN3dyIm53a+kVXO3Xqu9IOdw4aqB2SzKNyBrYQIu8+JEVJoGY5R49ejMAC0NdcczYP7rZ5c6LCi6wEVpYAn798EXKPXVZ1Sh9uhKWrrrWav/gIBPf/F+YDHq5F0xkyhxK7H6WVVhxU5IqHU50hsnN+Xw1bxB6DTh/GuQwRMtXs2sx5RsIB+tfTlIiSfUr+/cMR1cThVbL9ixVhUBxcy68O5/ojlmWVXvix7sAN//P1uxF6uf6VCg4O2SRVxeH0zOk7ITxgECg5NGzqKcCTSmEN/n2euFngweSbYF7Jvt4YcyIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <a4bf7c00-4249-cd67-c183-31cd7c019a40@opensynergy.com>
Date: Thu, 27 Apr 2023 16:34:56 +0200
Content-Language: en-US
To: =?UTF-8?Q?Bart=c5=82omiej_Grzesik?= <bgrzesik@google.com>
Cc: =?UTF-8?Q?Bart=c5=82omiej_Grzesik?= <bag@semihalf.com>,
 Alexandre Courbot <acourbot@chromium.org>, Cornelia Huck
 <cohuck@redhat.com>, virtio-dev@lists.oasis-open.org,
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
 Albert Esteve <aesteve@redhat.com>, "srosek@google.com" <srosek@google.com>,
 "zyta@google.com" <zyta@google.com>, hmazur@google.com, mikrawczyk@google.com
References: <20221208072325.2259940-1-acourbot@chromium.org>
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
 <d83a8f62-a2c8-8f8d-46ed-0d747daca4d3@opensynergy.com>
 <CAKxn3ec7nDy9B0nyHUg3GfXt_oktrC91kB3QWXM-sGh8ectE5A@mail.gmail.com>
From: Alexander Gordeev <alexander.gordeev@opensynergy.com>
In-Reply-To: <CAKxn3ec7nDy9B0nyHUg3GfXt_oktrC91kB3QWXM-sGh8ectE5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE1P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:79::9) To BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:4d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2663:EE_|FR3P281MB3069:EE_
X-MS-Office365-Filtering-Correlation-Id: 40bf7428-a42d-4efb-507f-08db472c9316
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tpsRo33DDEmazRnveZlw7fqJywwUlZfqg6R3U2NTfRYyRc0nbh2CNRpdMsOEz8OWTtHAbLS/QURT+UEknmJnpKqZhUJ7HdxTfrrwnJX4FvIenoj5mJhE3H/gKoPqyO4oMSX+aU0xiiScH+wgi1WWBB0eGmxi2d1B1QLVyX6r/WjYwXuXNlEg2YxKGBRQX2DEKK8+BtGVq7foMjudYt+1eTpF1XiyCa2weOH572oXk5j657JDfRO7zVgyMt510EEe85onwwWh2Y/A6QuxGFOvkbo3Yzgh5e5XTrSs0i3H1mZRA+7kqbB3JZ0mGtLBBD0eBwvF8CGc65fzcVO2sEF0jfB7fBAIz4rSHgHVHp2+xrHRvdJa9B5OjWAIRL9WztQfP0pMIn5pg84ZBFEwx9o6kqdRoEodVo+ETapqWZVPl5Y3DwRtpa0B1dcKUBVqHEM2eFNCHwiR0lH+WbNnzeDFu4kWVFr9Tju6h/pZY8bXjgWONQo3J/ZD/Eme3Fl86ZesNtm0eyU7nek8kfZU8r5DzFbomGyeKOnh9uFNDUjq86M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(396003)(366004)(39840400004)(451199021)(31696002)(86362001)(15974865002)(36756003)(2906002)(31686004)(66899021)(53546011)(186003)(66574015)(83380400001)(2616005)(44832011)(26005)(4326008)(66556008)(66946007)(42186006)(6916009)(478600001)(316002)(54906003)(66476007)(38100700002)(41300700001)(8676002)(5660300002)(7416002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1NOMkZvQTdyTWJHaE02dk53SDEyenZUdmo0bkNjeEtVOExMRCs0UVh2NHZm?=
 =?utf-8?B?RCtqOGJYMDdvTzNYM3JwYndlb0ZsQy9tZlF3dHJEdU1EK0d0SHJleDg5L1lq?=
 =?utf-8?B?bmxoLzRFMk9sRTFtNUJlRnhnQXJHdU1UVXk0NlltWnl6aHdIZ3NxYzBYSHdu?=
 =?utf-8?B?RlN1aVBTMjUvSzlORm01SmZPQW95cUxHZ1hXOUtsMkpkQkM1YnpuYy82bzZR?=
 =?utf-8?B?Qkt4c1BCTnJraDdoSGl3cVNWMHpieE5yZ1FmWEhkMHl5MitFUC9TSy9zRXhL?=
 =?utf-8?B?azBMQlgyT1BhWk05cUVKN2l4bFVUNEwvNnhoVUM4U29lN25WOTVsYitma2FB?=
 =?utf-8?B?L1BnNGZ2UGphdDJJcm92a3VWNmhITDZ2N0FKLzExdWU5dUJ2K0g2SVR6RElU?=
 =?utf-8?B?Ryt1UnNZYThacUpvQmQ0bHdZZ1ZPdDJPQyswMy8vOW1wZW5tWTdkTDYwRHJl?=
 =?utf-8?B?UDlRdDFkSkNjNkFLWGdOS0pNS1NEU2I0RXNLRW43azhUYW43UWJoamJjd0hW?=
 =?utf-8?B?RXBNY2VMVGdmd3ZyVzMzbnRadFl3elBSMWhrOGlBYjl2dzhsSy9SMTJrK1Zo?=
 =?utf-8?B?aExLT0lReVZMMDU0V3hJenRoR2JnTHF4bnVRaHdtZ1lFcDhKVkVLMW1NN1Ju?=
 =?utf-8?B?bDZrcmJxb1FoL3V3K1BsVVJCcTl2dGE4WlBuMzBkdjc5ZWk5S295VkVnNmdu?=
 =?utf-8?B?dzh6anJtbTZQK3ZMTmNOelVhK2tvQjhCVm54a0RtZXVWekRXalZjaU9WdFhu?=
 =?utf-8?B?TWk5cUozbnVVWnAwZ3R4N0xwWFZzdEZGVjI3WWsvQ2F6YXNWZHk1V0dReTlq?=
 =?utf-8?B?VlpjYlhaT1Y3cmRvWVJ3L2llcmd5eUlXendhK2FRaS9VdldkSzBQcmphQ0hj?=
 =?utf-8?B?TGJoWlZQQzJHUldBeEFEWHR4ZDIveVFUUVk4Q3F6UkFkeTlJQU51Tkh6NENF?=
 =?utf-8?B?c3pmNloyLzkveERRaVkyZkROSzNTaUxqT3ZqYURXVDdzcTM5VHBEeDcxbW41?=
 =?utf-8?B?NEtRbkswdVVjS3FNSnZ4TnViUmxIQ1pXUVVhUUliY01EL0R0Y3Y2M01UVzNr?=
 =?utf-8?B?MEw1dG5sNlRLZXBueG5ZSjVxeEUrREM3Qmd5RmdWUlQ5cjlBaFlIbmFNMjhB?=
 =?utf-8?B?bkllS1J6SytvNWZZQ0I4R1h3V0M1ZWZDbDdFdHMxUTVtUTMrVGFmQkVKcndE?=
 =?utf-8?B?MjhNMWY2RWFPV29Za29MVU1BTXdZM2NMSnJpaEV0aXVacnVpV1FQbTlmcW8x?=
 =?utf-8?B?NnRHV3ZMZ0J0SENLRlpMZjkwYUJaYjU2VzhjaU1Nay84SjJXWmNHMVJldWVV?=
 =?utf-8?B?c3hETU5ld3BHRG5GNjNQTGJ4R3FldTRuOVV0blI1VzJQQ2ZVNXBXKzhYYm9m?=
 =?utf-8?B?OFBJOElyMW81RU5tckdFbUFwQXRKRWdmQ0FxVldPTzJhNjJkTHhRbC9aejNp?=
 =?utf-8?B?elFTVVo0QkdwQTFGbnVGTjVHYkpnU21kY2pEUlEyUnRlWmtsdEJWUjNZbFMz?=
 =?utf-8?B?ZTNzMm1QUzdpTjVuV3JiWWkrY3g3M0JUcjFRa3JCMU5XanZFMWJQRjdEQlNz?=
 =?utf-8?B?cWhRKzQ5MTludFVWVHN3YkpFRzRmeTlGUzk0NEpRcHRxSGxzT1ZoNzJlVWZ0?=
 =?utf-8?B?YjlYQ25jY3VQczdDcTl3elVMNFBNUVh6WWxWcFFuYU1GWFNFdGZTc3R2ditp?=
 =?utf-8?B?VEhkNFYzb0VGVXYybW9iVThwdVRSdlNLVlpxTkNMSGsxL0dkNERXa0hES1VP?=
 =?utf-8?B?ck8vR3gvS1lhQ2xVTHNwSUdYQ1Qva09yWXhVYXFjWFE2Rkk3WkdVb0VxUDBx?=
 =?utf-8?B?MUROczNTdC9pWFljWTIrVTdOd3B4VVBXT2tKUDFhRmlwWE5hVjNLOEc5R0hE?=
 =?utf-8?B?OXNrOUs5MXBxWkZQOTJwSlhqeisxRVFlTDdqckswZFlOenBPZ01VYWY5N3NJ?=
 =?utf-8?B?YnFuN0FmeWRqOW5sUGJmRk8vTTJyYVJvdmhSWVhJUHNGd2FiQTBPSXBJcE0y?=
 =?utf-8?B?bkVXNlBYOC9qQ01TSlFoYllWNURkY3gxQ2llTm15TTV1VVFzalZoOHNMOUVj?=
 =?utf-8?B?R3RESE1Pa2tlRGlWUWcwNWorYk5GWUQ1Q2ZhV0lyaUR4aHJzc2c4RUVHYWwv?=
 =?utf-8?Q?7gAJroa76pa+LOJyRKzntTmeA?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40bf7428-a42d-4efb-507f-08db472c9316
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 14:34:57.6218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 36A3Q1kRyN/JelcN/kjFPrYQrI3B/ELhNzhrJiPtpBsB96QVidhTeVqrR1cFCKyeosFsd7UgEYB7sTiyEgo+Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB3069
X-TM-AS-ERS: 104.47.11.174-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1007-27590.007
X-TMASE-Result: 10--37.741900-4.000000
X-TMASE-MatchedRID: yebcs53SkkD/9O/B1c/Qy6n9fPsu8s0a9mojSc/N3QdlEv6AItKWF0ex
	crp35mDBWxjOUDkI5yCqW4fU4IlE4xzrJSe8bfGqTipLDaMylH0Ex2nnXvzNI0S0FpbI+14TCg4
	+Ouv0RSNV7gosQ1S3r8QXghxVFCP6qwoHAABsrQjwgrvJFY9E0YSkFXHm1a8tw62uSG5kL1b819
	1lvAtzOVSZHlAHrcAQ5YAvdCWT1bBJsyjYmmAr9I61Z+HJnvsOHA5wH3/21xHQv3GMCZUaFuc2M
	U6CoC3kT+8v17QjdI32BVCy1JdixTWs2YGWPbxrOIQ9GP2P2u9PnKxAOPp4WUty8cifGH0UGzEl
	PJ3tb7zY3iIlWCEIE1fgsRf3Qcdcgrm7ABCnURcF7cpFXK76TS3zVP69qL9nOmcd2FDUExsbpyW
	dc/Bd+X4Mw1s8WlGB79OsZb/ImRZ72OvVd+sqHhSceev8ZtpPjlRp8uau9oZuhQbABd4QQ76gCa
	8feq9dAd0cn1fMeA4AdHZZZOB38Vi4F1ScQrWQARprIm1hk20XjfR3d0weRoRRGq94HkP9SzCB6
	PyBOYFaYFHxXDqlaLsoYtanTEdis9gvQBjr0DQ6HG6H9FokcQ+eaGMA+lYQ18oX+MrbIuLGD0/N
	uzV8CycFWpzXYgAQbT4Iw1SEvyWpy+eDOQsxECsIuzCLc2mNhCu4DtwhzEuiq22tZRiubi01/iB
	n2qTGbSL9AN4UjltBjv8UmknoE2FqPXSLpNdA0VcKkOWxC5T+Ngp31WVSjq2tR87ciAnUMVu9Z5
	Q4LonjWDjwU7WXph/V22sqfGbdSm+sO4kiPx+eAiCmPx4NwFkMvWAuahr8+gD2vYtOFhgqtq5d3
	cxkNQP90fJP9eHt
X-TMASE-XGENCLOUD: 93df93ee-c5f0-4848-a92b-13999edf13e6-0-0-200-0
X-TM-Deliver-Signature: BBC2F938301C623B019857E96DC25A5E
X-TM-Addin-Auth: 12KAMt40vNt+43PykdVt7nM13emFebZ/iol1MulwtMxQKRWWaRhflSkNava
	I1quLemjnOBXsWn3Xj33yxoBxWzBkIhpTZ4sKCtAHs/DcMmmIKvX60WsLAYnEB+kIf7i07O4o55
	fwWFBuJuNUS3BtG8h1liGdf5ZH/GL5ZqU3p1NuLSGk8kg5cIUtARTdhUNaOGZOGWoXLAG9sQg0n
	vVuVNKC5e9rQa5mkteL7WBHFc+UGxfFaT+Hxb1IHBVambEkcTEheq+FHJQpq+8WtoWVON0g4BoM
	QWDXNAf9rYWG66w=.DB/2CK221IVhOIV8t0krnrNrTmBDePFVMLVgdK3qY7GyKJiCNhbraiwy8Q
	cOEbUfyaoiFBPbZy7eEojYYv6OsrMDRFsP6q3RgiHeP+zdZX141P+KbilDWwehGM37g1Ltsknkr
	98ON8FWt6xuPmr1tInD40VFyGcoZo4pc623489TkZwO4vLAs3WPA7VG37vFGVBajW+C/9o8cRYh
	HITgyFVUMbB39d6Ug/u3SCwFsFb0djB/8L0BfQ/H21GbW0ZoJiG9AyvGkZPA4Dn8BnJdVCvBmTf
	P0hrkA3777OmvQ6zbF1FA+VfcimjaOkmQ5ZsAQRR0NrXfosshdmp4cFeIYA==
X-TM-Addin-ProductCode: EMS
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification

On 27.04.23 12:13, Bart=C5=82omiej Grzesik wrote:
> Hi Alexander
>
> On Wed, Apr 26, 2023 at 6:00=E2=80=AFPM Alexander Gordeev
> <alexander.gordeev@opensynergy.com> wrote:
>>
>> Hi Bart=C5=82omiej,
>>
>> On 21.04.23 13:49, Bart=C5=82omiej Grzesik wrote:
>>> +CC chromeos-arc-video-eng team that also works on virtio-video
>>>
>>> Hi everyone!
>>>
>>>   From the experience of working on virtio-video I can definitely agree
>>> with Alex Courbot, that moving to virtio-v4l2 will be a great move.
>>> This move will not only simply things a lot but also allow us things li=
ke
>>> vhost-net like implementation for some devices (however this is
>>> thinking way ahead and linux only).
>>>
>>> One added benefit of this move that I'd like to point out now, that
>>> probably
>>> haven't been mentioned before, is moving to asynchronous resource queue
>>> call. Previously `VIRTIO_VIDEO_CMD_RESOURCE_QUEUE` have been
>>> synchronous and caused one hard to debug bug caused by this flawed
>>> design. During the command execution the virtio queue descriptors are
>>> blocked, potentially leading to dead locking the device. The implementa=
tion
>>> of virtio-v4l2 (even as is - btw nice work Alex!) eliminates this issue
>>> by moving to asynchronous response of the resource queue (VIDIOC_QBUF).
>>
>> Thanks for your valuable feedback! Could you please share some details
>> about the bug? That would be very helpful. I'm working on the next
>> version of the virtio-video draft, so I can change it there. I like the
>> idea to use V4L2 as a reference, so we should probably do it like it is
>> done there, only simpler. Still it would be interesting to know the
>> details, because we didn't have issues with the current design.
>
> In this bug, an app preallocated and enqueued all output buffers (to
> CAPTURE queue). This is inline with V4L2 and in case of virtualized video
> stack helps with latency. Those enqueued buffers are holding virtqueue
> descriptors until filled with a decoded frame. While for one stream it is=
 not an
> issue, but for more simultaneous streams, it quickly becomes a serious
> problem. In our case all descriptors from the virtqueue were consumed
> by enqueued output buffers and no other command could be issued
> to hypervisor. This dead locked the entire driver, by starving the driver=
 with
> descriptors - even STREAM_DESTROY command could not be issued and
> only solution was to reboot the guest.
>
> While it is easily solvable by adjusting the size of the virtqueue, it
> is a flaw to
> this design. The number would always have to a function of maximum number
> of supported streams - raising rather quickly.
>
> I remember having a few thoughts on how it could be solved and I think th=
at
> removing the need to block those descriptors is the best approach in my o=
pinion.
> One would argue that preallocating descriptors for this purpose or splitt=
ing
> the command queue to input, output and control might be a viable solution
> or per stream. However it would only delay the issue in time or could
> cause other streams to "starve".

Thank you for the detailed description. This makes total sense to me
indeed. I thought about this problem some time and discussed it with my
colleagues. Indeed looks like it would be best to stop blocking these
descriptors. We can add more queues, but this doesn't look scalable
indeed. There are several ways to unblock the descriptors, I think.
First, we can do the same thing as in V4L2: add a separate (blocking?)
DEQUEUE command. But then we theoretically can have the same problem
with DRAIN, because it also blocks. So why not just use the event queue
to receive the completion events for both QUEUE and DRAIN commands
asynchronously? One could argue, that the errors should maybe come out
of band. But at the same time we already use event queue to deliver
dynamic resolution change events, that clearly should be delivered with
the flow of buffers.

> Porting asynchronous dequeueing of resources would bring the virtio-video
> extremely close to virtio-v4l2 and therefore I support Alexandre idea to =
use
> v4l2 as a protocol.


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

