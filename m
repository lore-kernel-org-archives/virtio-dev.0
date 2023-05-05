Return-Path: <virtio-dev-return-12571-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB418C77B75
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 11:55:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C774A16A410
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 11:54:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A83C89866BA
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 11:54:59 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8BFC998653E; Fri,  5 May 2023 11:54:59 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 78BE598665C
	for <virtio-dev@lists.oasis-open.org>; Fri,  5 May 2023 11:54:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1683287695.517000
X-TM-MAIL-UUID: 93a20c00-9bbb-4dfe-823e-8dfac8e04e6a
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpP3Dzy8a6qzS5jaA/Yc8BR30Yeszd7ncCeYlKoTlTOmzG+lyVQqWMAnlOaRHJwHa6sxqDXAL2QxU6iYabGE3L6fdxHQtxBYrNbnIQQCZNAAP8sgqlBAsqEiUaUBQLTGml3dGmoak9Igj1ijOjWfD6qMQMxWvRkhikvxBym/ybyxCyYT9SG0wTtmOwRz1eNU+vFm0ymNyGC45nGJLPwsmt/6j6Uo2nvWxzkxQ88Bzvoy1nK8Wr/xZdYOEd3otr0Y8jLL7efC2xPYqkVPaD4SedrEvf6/eKBXgw5UT2dd5ZFv+rbWK5VXJkDoWS0yk7LQ8/iRLHVx1heBxii9ht4F8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+di9DxHSCjmUfyvAXYSLg/zMDkSvdy2huzt04JGjO4=;
 b=HUY9Fs1AN9s5JBAUyQ2zHGqhx94gK8f3Mg3VzLVXkw/DHtZX8Bp6krh++z/shj5klCVk6365qbgD3nOlY5zl6OAPmJYZskq5YkVy/+B7lrL+8GHYy5Haoypuovdpia2A2vmZltSYjlf6AAuvCaJGFNAJQlY00Lz/YlNTFLdqnkZ1yVdDjQIql2mwp82ZwD2YKOQC7wvEy3fPrARJmglRmFEJBei7lTFdakNGRX3Jdav+IiIIh1wK0m2QuFG2rowBdNpyAGlNuNzP/enopnkobNEPwTLnYCX63Qw0xWvnPDQz3jEx2WR+Lo5BLZjcdmdq7HR54LnS+LEcoBoPNK0VPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <8ee0075c-2604-9fc2-27c0-f68e32e2a923@opensynergy.com>
Date: Fri, 5 May 2023 13:54:50 +0200
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>,
 Alexandre Courbot <acourbot@chromium.org>
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
 <87a5ylzf34.fsf@redhat.com>
From: Alexander Gordeev <alexander.gordeev@opensynergy.com>
In-Reply-To: <87a5ylzf34.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE1P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7b::9) To BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:4d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2663:EE_|BE1P281MB3059:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b904bea-d9c3-4a98-7d0e-08db4d5f8a36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nVH9LQgEI3k0hdbJTjhgXMg1ZtnzVpaCrVZVolYDK9Ottl4Rpa93aa8xYSle5F0LiDWq32zLnwAOyabkVgTSchYHzF/YA8BMxFugoQ09H52RNKbsGy/1QUErNLuhozPyEWNV9vSDz+3DKZdHohEBHRJjrA4qpCm2a0uJzMmk+EctVYM5mhXQW0pASdR8sOPGAjDmXGMGcBNgYii1SYdkosGVuZayGOzb8kDXJ0bdEhgV6CLXzBP93lng6S3zQnIbVa1SjhIGjNZrL7iodsEvBjYGIENulMM6nqcd4pp6J43Ac9Ukv4KCoj1jMi04noDJssS7ANdbHjizAGiIHzezf9K1rQtvNindZlOGtLbJS+L7ZJO/nEuH6nDF3KkfKVHkcH5guCMSK3EOg2cXC1z7T+lHsyZ1/MFL7s86Xb/+fbmDv14UI/H0yr51TwdLh91NFt6ij2vsgWA6KgnodFe3zaAx3SrW4IPP67hPfiwRy8piixgh/Ej+diWmaRDrESPthkkYkEoGHlZufRokV9Eh+0gP00KKAVX3mXPdMEeV/7k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(376002)(366004)(39840400004)(451199021)(83380400001)(66574015)(2616005)(66946007)(66556008)(66476007)(53546011)(478600001)(110136005)(5660300002)(54906003)(186003)(2906002)(36756003)(31696002)(8676002)(44832011)(86362001)(7416002)(26005)(15974865002)(8936002)(4326008)(41300700001)(38100700002)(316002)(31686004)(42186006)(66899021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajBCUlM2bGswY3hRK3hqSk85L1NwczJWVm40ZjRtREUzQ21EQXRKUVNRUTE3?=
 =?utf-8?B?Rkd6REhwbjdZZ2d0NCt3a1p3TTV4dTF3c3lsU2JGOU9kU1RORWV4TTdhZTdC?=
 =?utf-8?B?NzBFanA4ZElCMHZTVTJVb09uWm9HZ01kNEZNV3hxWXdma2cxRjVISmV0SU9D?=
 =?utf-8?B?VDJaZGhvcWFmQ3FvWWVVMjJ2Qk4yUGpZUi80UmZ3UVF0K3NVeHJRMU0vaGMx?=
 =?utf-8?B?Tmx4WVh0anZ0MjRVS1NQV0sxOGRUWVlhS0ZyR051dHR6VjliZGZTK29KR0c4?=
 =?utf-8?B?WVR2TUlLV0NHdFBHdGpOSjhIeDlEVUpFS0ZJVytZdldNOUJNNmNKcHpHU01N?=
 =?utf-8?B?K1IwcWVHQjB6Z0lnelB5Sklta09XMDV3eFZvbzRIZGNHcE9QWE9LYk1QYnlI?=
 =?utf-8?B?MzI1ZzB0eGNvdWlXVXBIclJqNTY0ejhSNVNVeVM0dnVYWitaSVEyY0xsM0pR?=
 =?utf-8?B?em1JUTEyLzllTldmNm5hQ3JBbFBZazUzK3NVdzN4S25BYUp0NWRlTGlkUUMr?=
 =?utf-8?B?UUpGYzNaeW1qeWN6akhycEYwV095UWxpZG1UU01LTmsra3hUaVdma3NwN3pi?=
 =?utf-8?B?cnhDQTJxQVVRcEszcHEvd3h0MHltWEJFaUtWREVhTGNoZGhqWmJQSUp6MHc0?=
 =?utf-8?B?eUZVNFBrMmdlVVJuQzEwK2V2UUtrbVZ4SXNHWHZxWjd1eitzRU44MVpGZXkv?=
 =?utf-8?B?NkUyMUpEdU5QWGZ5dkhqT29OMWdTRk9iYVRRdUdZak44OE1NdjNFWWxmbHQ1?=
 =?utf-8?B?RGtheFZKQUhBY09tY1pGVHhRTE4zclBXcGhTOVFhb1krUEhBNkVhaitSK1NF?=
 =?utf-8?B?MFA3cHMza3lHMG1vU1lIbWlmSElrM2Rwb0FKdVk4bTJyZlNxMlJxMDNtcUxY?=
 =?utf-8?B?QUtwODFaODVJVlYvMmZTT3UwNmgvRE9id0Nia0lFNFpTY1JVYVpzTFNXdng5?=
 =?utf-8?B?TlBlY1FMcGRzbEdTV2xHWXNlUjZOZmVoYmljTkVVS3pmcGJ4VU5LaTRiVmV0?=
 =?utf-8?B?SytvaFB4QUhqY2lCTWVVN0xkT3ZPeklVZUR3NnBKejIwZGQ2YUxHK0ExanN2?=
 =?utf-8?B?ellZdGF0bCtNclR1czN2MStFYXZ5WkhtWTl0L0VrakY0ZDV1OXpza1hKSi9v?=
 =?utf-8?B?SHFDOG56T1djMDU1bkdTQWVFeVNITzduTTFvb1E4VlpGQlludVczM25tcjdz?=
 =?utf-8?B?bGVVcktYc0hidkdlNkthenhIdDFrYktCVytTWDRESUdSeXJGYWVNREN0TlV5?=
 =?utf-8?B?QW40Z1luSmxUT2V3S2xxOFhPankvUzJyWExHM2RpU1BQK1dNYlp4aU5MWEVi?=
 =?utf-8?B?Vm5xdVRiYWFvQndkWjBUZjBSTTM0dDlqeFJLcWVUdzcwckJRUzdWbzZBSFpw?=
 =?utf-8?B?TjE3bFlybkduaUZWekVNTGphUjRKTmpnK21WWW1LQm1MZTFCMkNhcG5DZzlY?=
 =?utf-8?B?S2JMTXVoRkZ0RFIrUFpkQzRld2JlSW9VbVdGenlzSzdEMC9PUEZjMlZPVnBI?=
 =?utf-8?B?VlpXLzQ3bDh0SXZFMjY0SW8zVWRsbzF5cFFyS1oyWFlXWkNMend3cjFFdXA1?=
 =?utf-8?B?SUFkaDgxcUNiMzZHVTlabVQzZVZSMnBpdittKy9FbjRZbG84bHZxVTUrcGxt?=
 =?utf-8?B?OWI2S0VrWTF2YkF5WnpiUHVId1duSUIwWFhJMGt3VmxuSnVzdEQxdHptTURI?=
 =?utf-8?B?cnVtejBpNFFKVkNjUUJHeFVyZWsrbnQvMVNaY3ExVFBSNkNYcThWajBpNFZI?=
 =?utf-8?B?bjFBeStiS3FYbjFRWkg5R1VGVExQTTR3aXVaZDZ2UDlpVTU3L1FPWFZXRVhE?=
 =?utf-8?B?R3FxTzBWUU1hZkM5a3NnVDhyanJEMkJIYkJTdDZ4RXpLUEdzejZKbTZzT1Z6?=
 =?utf-8?B?eFVxMlRyNkZNSzYxckxjOTVNWWtCUEtvcVpkSDc0a1J6cXhPT051dkFqUHZK?=
 =?utf-8?B?L0Npc3dRV1c5WkQ4YzlDTGNhaHcxWGZ6dER6eElOZzQ2cll0UkJYOHY4S3Nm?=
 =?utf-8?B?UHc5dFZMdTFvM1B0MGZoR1RZcEtvbkd4S25Udi9QZGF6WCtnMjRod1dldVNP?=
 =?utf-8?B?a1NHMzRkRzV3cStUUTBJYWd1eXc4T0x6OHcvQXNkWkkydHpGZWFGa3B1cVNP?=
 =?utf-8?Q?WP0pLytFae0OdWUG9uDmPgQYk?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b904bea-d9c3-4a98-7d0e-08db4d5f8a36
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 11:54:54.0516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KU00sGNxckvZg9J7FbDWTggd1lmsbk0WaBvzm93tokZBubuMaWbaaohrRsjnorbYPwaYLbEfLtjIqIIbaM9Ncw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB3059
X-TM-AS-ERS: 104.47.7.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1007-27606.006
X-TMASE-Result: 10--19.590300-4.000000
X-TMASE-MatchedRID: 9vvqFUF7IWn/9O/B1c/Qy6n9fPsu8s0a9mojSc/N3QeqvcIF1TcLYLK6
	GmKppGdqLVqxk9o1HBxAKEp+2HkEbv27vtwnQ39AIi5n/oIUxv+/KQGKQH1rQFAoBBK61BhcGDr
	P8zNo4TwMf7Ce+LIFds5yw/YC8uhnp1reWSY5Jcf0hv/rD7WVZKPLTdfaE15XQmw1cPfvj6maY/
	lzalOje6e76VC6sRoK8uypKo/12dOrofp7IohGwyhvVjkRcuKhAajW+EL+laOtBiS9hFeaTOfE4
	NGuUaNHfWrgQNsTIWqUI512D01p9G7lkbyMKxttFDuTLTe6zcM10wJPYcToKOG+Zh3WhTMgmJcL
	P7rUhL3UIKC2z1kBEdpMCG/45IqXTBIvvf0y3tpp5gkCyfx58NH5oKdS2Y9o2Ac5yB+gHxG7/0B
	xnEcafaA/I+OhkQjNWcOfLwYDyuRSIWBbLl0/Z6jFA2STVo+4rL4LuDUDfbsXYnaoL/fgO5AjzB
	s6pqF7SpAFNe4DUJ4LEofWrUZHMF8+dSqKgz8/dhkilCSjv7UNW4va9iqt3kiR8OQ2sx2mzKACX
	7I5tE6KXPHHXDmlw+4nDl0cg6mqS7hEDnJ1r2tEdKCMKDD8ldgLUFO3NWv3nJDroZe9KUMyhfTm
	1Gq0SDrIBI/js8HeaIPrw5+LqDeXBXaJoB9JZ4MbH85DUZXyseWplitmp0j6C0ePs7A07QKmARN
	5PTKc
X-TMASE-XGENCLOUD: 45ad5b74-71de-4d59-8645-0ff69c058a45-0-0-200-0
X-TM-Deliver-Signature: 2ACDD9037317EF53EFBFB928BEA86D52
X-TM-Addin-Auth: Vx62pIfmTwK4G+IsBV+iWqc/c8t81I89qxAmZUt0Ot1c1zASfwMEqzAx8Fx
	2fAwKfkDTKz/zivDNDvcGNhjcQ6pYzC0QV3dZUBBMGKGA0dQail+D9lKGIOYZzaoCN622zQJYdq
	xcyk797tH8jinZMoHXr6sx4elb+0oSRHekgA2n15LfDm8gDaVuAI61OLk0NJyZIo5BD6iriGFOh
	PVaSXLLXiDSbgd40QuOQHWILRO2hAw6GkDdY1KYPNGaAr5qcCsL6CkGqfUXg+loFqNQqAcbrKpM
	fRjRhg/T/vfCAeI=.hD1bvU79dtpTJVXPs/Km/OFXgOp3/m1ZyirAXe5d0WlJeQKPIJKa2W8wxC
	auukV4kU5pMOv4WZB/Fzw0pByY8UtYG+CJDzlEDFNlOeMp+dTT1ctBCf5BK4wStfo50V+NTpgRs
	jIcHpa1D9LMw0Z4/cX4S2ItUieIIRD04NtaMI/rxIvIeiUJlDO8JTLSIFJG21EhZohma1BlhgcL
	2iul0xZAHdpH5LfUHHOMdNMJI03xxtDaErxh/em982ER1ADWmLn9I8dwA6ZCSjgy7FKN5PgiTyR
	s8CuikGO9S6aXTStTQn3kEWdWDHUb6HzbryNONzRSHzcJvqV8ON45L2lI2w==
X-TM-Addin-ProductCode: EMS
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification

On 03.05.23 16:04, Cornelia Huck wrote:
> On Fri, Apr 28 2023, Alexander Gordeev <alexander.gordeev@opensynergy.com=
> wrote:
>
>> On 27.04.23 15:16, Alexandre Courbot wrote:
>>> But in any case, that's irrelevant to the guest-host interface, and I
>>> think a big part of the disagreement stems from the misconception that
>>> V4L2 absolutely needs to be used on either the guest or the host,
>>> which is absolutely not the case.
>>
>> I understand this, of course. I'm arguing, that it is harder to
>> implement it, get it straight and then maintain it over years. Also it
>> brings limitations, that sometimes can be workarounded in the virtio
>> spec, but this always comes at a cost of decreased readability and
>> increased complexity. Overall it looks clearly as a downgrade compared
>> to virtio-video for our use-case. And I believe it would be the same for
>> every developer, that has to actually implement the spec, not just do
>> the pass through. So if we think of V4L2 UAPI pass through as a
>> compatibility device (which I believe it is), then it is fine to have
>> both and keep improving the virtio-video, including taking the best
>> ideas from the V4L2 and overall using it as a reference to make writing
>> the driver simpler.
>
> Let me jump in here and ask another question:
>
> Imagine that, some years in the future, somebody wants to add a virtio
> device for handling video encoding/decoding to their hypervisor.
>
> Option 1: There are different devices to chose from. How is the person
> implementing this supposed to pick a device? They might have a narrow
> use case, where it is clear which of the devices is the one that needs to
> be supported; but they also might have multiple, diverse use cases, and
> end up needing to implement all of the devices.

I think in this case virtio-v4l2 should be used as a compatibility
device exclusively. This means discouraging increasing its complexity
even more with more patches in the spec. virtio-video should eventually
cover all the use-cases of V4L2, so I think it is reasonable to use it
in both complex use-cases and in simple use-cases, where there is no
decoder/encoder V4L2 device on the host.

> Option 2: There is one device with various optional features. The person
> implementing this can start off with a certain subset of features
> depending on their expected use cases, and add to it later, if needed;
> but the upfront complexity might be too high for specialized use cases.

In this case I'd prefer to have the simpler device first, that is the
current virtio-video, then to add features incrementally using feature
flags and taking into account the virtualization context. V4L2 is a
complex thing from a different context. They already tried to carve out
some of the use-cases like stateful decoder/encoder API, but this work
is not finished (struct v4l2_buffer can serve as an evidence). This is
like dissecting a monolith. Also it has to be patched to make it more
appropriate for virtualization (we can see this in Alexandre's PoC already)=
.

> Leaving concrete references to V4L2 out of the picture, we're currently
> trying to decide whether our future will be more like Option 1 or Option
> 2, with their respective trade-offs.

I'd like to rely on opinions of people, who know more about virtio
development and goals. I would be happy to present or reiterate my
arguments to anyone interested if necessary.

> I'm slightly biased towards Option 2; does it look feasible at all, or
> am I missing something essential here? (I had the impression that some
> previous confusion had been cleared up; apologies in advance if I'm
> misrepresenting things.)

Indeed some of the previous confusion has been cleared up. But not the
key thing. Alexandre still claims, that this patched V4L2 UAPI pass
through is only marginally more complex, for example. I don't agree with
this and I have evidence. We haven't finished discussing this evidence.

> I'd really love to see some kind of consensus for 1.3, if at all
> possible :)

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

