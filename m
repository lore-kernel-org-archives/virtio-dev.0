Return-Path: <virtio-dev-return-12309-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FD1C77B73
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 07:39:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 46DE12B014
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 07:39:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 21FAE98643A
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 07:39:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 082A998641B; Wed, 19 Apr 2023 07:39:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EC00F98641E
	for <virtio-dev@lists.oasis-open.org>; Wed, 19 Apr 2023 07:39:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1681889968.309000
X-TM-MAIL-UUID: 4cd06ea0-4d7a-4330-aa13-740f6334b532
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9r3J5l7vjigFUF2vmvQm/ismnbQ7iAntDpVCqpw68dHYOd8wyi9CPtOOb2EB2NUBRzRPRwvHMvTdAbKgomgUnCwRR05cSpnT+8e2tdj7fPFXlsPtf8GwzsZhDKm0h30xjqKauR5AU9Z+S0m/ydgPAr4CCJInuNG3220qUQHM+b0YhTihvr0O1sDmGbRmyNyHpVHUFtruA/sG1fPPBShsdUt2TDWC6ECn1M9XP4otd84Sh7lF55urBFXwi360bk3bn7yffor9XTlePYXD7WaAlYAUtLAT3yzUaqEVkSaqukIFzNhcNyKXejPozMVCgFi1ACsDbcfM/gPxECu0goZ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sI6i0J/wLNVfPZai7uJtvF/bhSAZMjORc+qf09200jU=;
 b=F2mbMpHLM7ZnyG9mXx2O08vciA3w9AVKxevYwuKTTzDQtJdtSXBvJQKoB7rKI0uV15iCJaDVkoGSiuPB4j9ySKsMJuIbifUspo/O4FU13maXeDWV+S/oCE8LQqXjyOxTYcyzLAOKjHIUZidJufWm6FDEbzc6Uf0bf4rW/+aR7U1PfvhyPM9lTyQEkm4Ua2T3c6b19q+gHkyjZKT53RMluKevSML2hBE8RBnc/gr60BFQNaRdFK9XIubNjrl5MM/C8mPJ1YZOH2GtA+ebiX3c67kOUqdyIdtZenM4cjT2eVcmH7xHByR1zlQ2F7eVDv61p865HIkrVaEejn1sOBBnlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <96978ce8-0837-2e08-f5ca-66587807798b@opensynergy.com>
Date: Wed, 19 Apr 2023 09:39:25 +0200
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
 <ca84a8f5-71ed-aea8-5751-60403d167283@opensynergy.com>
 <CAPBb6MUDWVK87_kGFen36tDJQoR-Les6djcKVihjuTKQBjweEQ@mail.gmail.com>
 <b5c9d69a-fbec-8046-225f-bdb5850bbd54@opensynergy.com>
 <87o7nmk1rs.fsf@redhat.com>
Content-Language: en-US
From: Alexander Gordeev <alexander.gordeev@opensynergy.com>
In-Reply-To: <87o7nmk1rs.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE1P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7b::20) To BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:4d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2663:EE_|FR0P281MB3081:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eba7260-cbb2-4345-4c98-08db40a9338a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GRRendfI+FPmuDDyde31rpwZEfUMhOMYMyihpAhsZZD14F/Zzk4pQCi6BsXD8P8U0fpQxoA+JWqwc41fa1b6AzzaKKGsMBazaPanIuVrH3AaJ8nOuGRzCZcGS1aZCanPweBIUSTLfeGuCn8f3HuV7Vnxk7ANwL65Hk+MbenpZCNrVM7Fb9bI1hWhXm2/4MgZhFC3pg/VhTMy27u4NHuw0I3x4f3E88/Qa3kquDDXm0dfSQnnUuT/EwcsG0in2veFMVSvDZoq4qB0vAz8P2TODGnjKxqiXzKHEd3h9+EcLmYFuK7yHjActVB1x03ApNhaqzEg3srNJBvb9CznMaddnGX6nYUUX7rm8Dk/fH4k19h0/R7pRxQCWqdMB543LLyjUrMA7ze06yOGzOSUThauI+Oqe9VIAipdGHSOcF9hFK983XPfBdlQOMwgrJEp04HKv5V5WnOiL+IV5/nyTjjTJNnoG3/vauSlc0aQDm9nbFnH+wmzuDDxRwdUFxyIdnFoNtN+ehjZyR7IdEqiAfewvmGw35V32u9OBtDKeBhyDJo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(136003)(396003)(39840400004)(366004)(451199021)(44832011)(5660300002)(8676002)(8936002)(7416002)(31686004)(4326008)(41300700001)(30864003)(316002)(66946007)(66476007)(66556008)(2906002)(66899021)(54906003)(42186006)(478600001)(110136005)(86362001)(31696002)(26005)(38100700002)(36756003)(15974865002)(83380400001)(186003)(2616005)(66574015)(53546011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajAwbGRYc0IrWDZRMks3MnN1aVpPMnU4cTJOaHFYaU5YV0Rlb0t6RUR5WEdG?=
 =?utf-8?B?VVFScklWOVNvTDA0djFxaWR3UDlTQmFtbGxmbVgreWkxQ0JwSUZ0emFtSDNW?=
 =?utf-8?B?anRMZGJtUCt4QStmMmVIQ3h2dTVhYm5icFNUSnpnemdXaXpKbUxDK3ZhV3FG?=
 =?utf-8?B?enZHeXREaE5PODBrdXYyM3d5by9PQ2thRDc0T3VOZ0FZQkJNVUJtOFVhU256?=
 =?utf-8?B?NzBIZDVlaGRCWlQrVll5Q00vS2JaZTJIa25HUVp3NkVMdlhLb01VbFFKYjRJ?=
 =?utf-8?B?RTV4emFtZXdJN2xNTG5UZ0hiSkNQUWhVTmJlQlh4dkVqME9Db3d3bTVOaHZB?=
 =?utf-8?B?K2diWVdrbTFBRkltK285V1BwVWV1c3gxK3N3V0RWMUJCNUd4d1F2VVluK08x?=
 =?utf-8?B?akJYWVVtTkphS2RTaTJUNG1mb1ZtOS9TLzJpMDRlR0dTWmNMdTN0OHRyUmNt?=
 =?utf-8?B?NXN6MXBPT3AxMTI4ZVhlRUJId1VMazN0UjBaK3h6enVQb3lFRFpmZm5seENw?=
 =?utf-8?B?UkVHSWlhQ045dFRNSlh3dDczWHllLzlCRUhvSnB3MG0vVWdrV2RoU1U0dHRB?=
 =?utf-8?B?T2tuNDV4by9xTVdjbEZCTVFWUm5jeDlZSXFod1pZQXVVZXpQZk94YnRRMVpY?=
 =?utf-8?B?OFgzVlp4NWcxQnZBQzRYWjlTWWtheDdaaEl1REkrT01wNHRvN3RVVXM4OUk3?=
 =?utf-8?B?NFhXbVE2RExUWmlSV3FFWG94a1R3WXN0NVR6VHRDZnpkaUpPcnlQRDNuUEpw?=
 =?utf-8?B?OHpQRmtGTDU0QWRPMWNqbkJqdWs2WWxTS3hqWjZYNUtKaXZCN0dyRE1MWVRO?=
 =?utf-8?B?bnlZUjlyczJwcmRpRDgzMEJXN2xwcEZXUWJoS1RJZE5Ua2xIdTh0SWlMUmdi?=
 =?utf-8?B?SDR0V1Z4ZUpWQ1pLSmhPeW4xazRHNG56QjZRTk1Xc25rUDhuU0QyN2tIQnR2?=
 =?utf-8?B?Z0M1bjc3a0JWTnZBaUlESjB1aEltRXluLzlHWFhDemZzaWpZeFA3dldxY1RK?=
 =?utf-8?B?UXo4ZlBHZ01UV0dzWDNHWm03WGVoTitqenl0aFJUM3pkcjN0UmIvVFE5Y3dz?=
 =?utf-8?B?aWVSQ0lLdmZHNHViOEI3N0tTTlR4eUpwbW5GZjN4WmdsOFR0SFV0aExHRGFl?=
 =?utf-8?B?MTdJcjNnVTFvQ1drVCtHc2IyU1ZCckJXQ0x1djBScjc2NzIyVmdtSkYwcHN4?=
 =?utf-8?B?UWo4bThLNW1DcWEySVlkazFhaG1FR0g0b3pUT0o2SCs2T09oVGszVWF5d2RS?=
 =?utf-8?B?dlJXcThNbUVrZ1cwUUFyM3RwK2NQUXE2LzdCVTFORnNXOWMzOUJyRWttNEZ1?=
 =?utf-8?B?Y2NsMjE0SFMzYTJjN0MzRFh3RTlTNkhGNUhkRFVtSEVxVnhjdzhJRVl4MmJM?=
 =?utf-8?B?UmpGWG9CWHNnYXpWS0hHc3pTSGc5SGJkMVpzYlhyOXNLbmZFa1J6UFVVcWRa?=
 =?utf-8?B?Tm84cXpaQzJqMXh3L1ZVcWJpUEUxUEE3QUxZOURndGhTOFpTYi9qMVM3bGtO?=
 =?utf-8?B?d002b1NTRzVlWUs4UXdrajk4YzVUcmZtWmlrK1ljRHdnS3VYNG1FL21wNU5V?=
 =?utf-8?B?L050UTFNa0VGUjVuREFIajV6UXhNY3pBRWc3MGYwRHlUUE1mdzJwWXBwWk9G?=
 =?utf-8?B?TkxvZHBUK1ZpS2NKUnVHREpyOUJoVjB1ZWRCbE03dms5K2hjOTUrU0UvMytY?=
 =?utf-8?B?bmV0bDlsUVh3RHZqaVNmWGY4RFl0djQ2ZlFJTk52azB0aEdKTmVhWUNhR255?=
 =?utf-8?B?RDhTczRsZG5zWnh2Z2tjKzVPenIycnBTYldMTzJGblZyVlpPTzBJeUdlU0lI?=
 =?utf-8?B?RVl4Wk9sUU1vTWt0K3g0MFZZc3JLbDNjUzd4ZVY5Z2xJUkNSTGt5dklaMkpu?=
 =?utf-8?B?d0FTUnllZFgzN3cyKzZHRThXNk1hRTVidUUweXJtK0pxN082eVFJV3Rna09a?=
 =?utf-8?B?MHJ4ZWlCalc1cW90NENjN05hdlM4QStzYVZKYWhoMUNWb1ViZG1HZWk0KzRa?=
 =?utf-8?B?c3NMUjlOQUhJbWNQN2sxMHNWY0NtZDM0KzM0S2UrRmE0NVdqclN2emM2bitF?=
 =?utf-8?B?RlBWKzA5czNTRmgrN1NZVjErWnc4UDUzaTZZUnJQSmRWSk9xY0JuQm5qSGY0?=
 =?utf-8?Q?wXDN/1FFtP0k+8xxTg7E2v240?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eba7260-cbb2-4345-4c98-08db40a9338a
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 07:39:26.3028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cyeIFsKnlKAXmGXR4wCsMLmuxgPfMdasjxvczIbGevCh+RJFZfg2nmXHLSs2zbVtiI0NcerLwX66EWqquNMpbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB3081
X-TM-AS-ERS: 104.47.7.175-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1007-27574.006
X-TMASE-Result: 10--25.604000-4.000000
X-TMASE-MatchedRID: jFqw+1pFnMz/9O/B1c/Qy6n9fPsu8s0a9mojSc/N3QdlEv6AItKWF/GG
	5PZMzxFoSJMpuNZVDMj7SMNvd0KhY2dkza/sEr/bTipLDaMylH1lH44U2Ru12g6QlBHhBZuwwHn
	0xXc+i1fVjMz0CrqjxAFSFLguAk632DJQA8IHlR2JJ72DuZB0nHZljA0GozoivDGpIrQZI9Gyuh
	piqaRnakUC8xjOyiAYn8ooMPOULLCbWeN5f/1O9P7FEhWgo0y85UEGKEYHy/dT2sHCJaGxJtt5e
	gvQ3UpXltawmHdJEaKpaHOlqq2WmWj+Msn9Q6VolX1trWRHDpOdUSty3D0zu5RBZFWQNAXmsImk
	qVt1t4Q+EbcLhsn25ysQk0u51/WTZvxJrutTlmre7nDcRrZeaByzHcgfiyrc1nkLa3J3C30qVsb
	4L54/mpDq1qD+jHaAPBJqz8SFyBJP+BqI4yHzfMb1bQPrwFnM82SgwNf6SK5QKAQSutQYXG0k60
	rxXmF4h6y6sVpgqH34pkcixuThjIx1g1lTiexdCbJWswK4n1LUoMiU4Mi75Zr58CksHfm3t3YGU
	cAiLMU67N42Y4Yqc1Y7maOxI4yf1vw2PCSYC/oASCpNzgtLhPWr7HvOSElaP4H+2nyK0FMF12zh
	TSR9X/Hv2a4cQYCLtgp/mSQ1GlVpY+rDpJtqXlaxq6bEGGO0twpUiv21DA1Q83MJcksFyTvIDoW
	evLURvdx9Sox4uW1kU/+rNPoTJajC6/MNUxOoVV4ZZmbE3YyR3FxNiThSbdGMGYFaxr1E9zDJVg
	Zmvsi937SvHAqETRBJV6IO+rXxsbbAxKlf0i1+yskgwrfsC30tCKdnhB581B0Hk1Q1KyJHtBsf5
	/UXJbVQu1GNZ+si4kYXbobxJbLyU/oX+tpNmCG2Ull2Wedt
X-TMASE-XGENCLOUD: 455f838a-6126-4385-8340-f284ee0eb243-0-0-200-0
X-TM-Deliver-Signature: 94A028265D87FCB3F6486375250AECE9
X-TM-Addin-Auth: dsHnSYg3m8IvBdc5MPVmWxVDMkdiB9AbcUnzgUCXK76OFK4/4MYw5Zm9VH+
	nvyt+RvEesaQeF4KUn5MFDkaqKjC3ALDzBisBQNXIRFeRmueXoo2zyYYTdDfELxQPI43yaalCuK
	YIxlxNM+I8w1LzXm3ZIz8MXMezJvzFg8I1QFjm+GMt0ncNtFW95G0y0CbmXUvUOj5k2yww2z0rD
	UynMvi7tA9baN/wUmMhYF3trVAlWiVKW06TLd3ShM5OffKkjuu6FytLNau7WXejW9v00XxCUSaE
	pc+XptVNteQqBSQ=.Fk/Z0ywuf+iV62LmX2QCf9Aa+m39CN1+R6lCoCkm5Hi2aZCd3PDo+qEj+J
	4571jDdwmUayRCsnEPcpD78cy7VhX2NFjJu/FIL/aUKYORruk4d5ZyDqaDBdXBjkb4P9+JTEbFU
	nmfD0Eda7quNLK0EF4Kfm68J1ZwlUS5lgxFeFO8PginSaKBPrEJhU+wV+6gOXUVzfdjnBYRSjhz
	xXB2FXT/eBslwS+qUX1ScGNhrTDtEy78807btxntrt1HbuxqYJpQsvD0koBgNg13fJLKXSg7ZWU
	kxWgoudIoP6ExmKlvNZiW0atRqgKfh1CJpjzhQLbr0cdyVWRcpQt+/RET/w==
X-TM-Addin-ProductCode: EMS
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification

On 17.04.23 16:43, Cornelia Huck wrote:
> On Mon, Apr 17 2023, Alexander Gordeev <alexander.gordeev@opensynergy.com=
> wrote:
>
>> Hi Alexandre,
>>
>> Thanks for you letter! Sorry, it took me some time to write an answer.
>>
>> First of all I'd like to describe my perspective a little bit because it
>> seems, that in many cases we (and other people writing their feedbacks)
>> simply have very different priorities and background.
> Thank you for describing the environment you want to use this in, this
> helps to understand the different use cases.

Yeah, I hope too. I should have done that earlier. I think Dmitry
described our use-case, but it was several years ago, so nobody
remembers of course. We should reiterate all the use-cases once in a while.


>> OpenSynergy, the company that I work for, develops a proprietary
>> hypervisor called COQOS mainly for automotive and aerospace domains. We
>> have our proprietary device implementations, but overall our goal is to
>> bring open standards into these quite closed domains and we're betting
>> big on virtio. The idea is to run safety-critical functions like cockpit
>> controller alongside with multimedia stuff in different VMs on the same
>> physical board. Right now they have it on separate physical devices. So
>> they already have maximum isolation. And we're trying to make this
>> equally safe on a single board. The benefit is the reduced costs and
>> some additional features. Of course, we also need features here, but at
>> the same time security and ease of certification are among the top of
>> our priorities. Nobody wants cars or planes to have security problems,
>> right? Also nobody really needs DVB and even more exotic devices in cars
>> and planes AFAIK.
>>
>> For the above mentioned reasons our COQOS hypervisor is running on bare
>> metal. Also memory management for the guests is mostly static. It is
>> possible to make a shared memory region between a device and a driver
>> managed by device in advance. But definitely no mapping of random host
>> pages on the fly is supported.
>>
>> AFAIU crosvm is about making Chrome OS more secure by putting every app
>> in its own virtualized environment, right? Both the host and guest are
>> linux. In this case I totally understand why V4L2 UAPI pass-through
>> feels like a right move. I guess, you'd like to make the switch to
>> virtualized apps as seemless as possible for your users. If they can't
>> use their DVBs anymore, they complain. And adding the virtualization
>> makes the whole thing more secure anyway. So I understand the desire to
>> have the range of supported devices as broad as possible. It is also
>> understandable that priorities are different with desktop
>> virtualization. Also I'm not trying to diminish the great work, that you
>> have done. It is just that from my perspective this looks like a step in
>> the wrong direction because of the mentioned concerns. So I'm going to
>> continue being a skeptic here, sorry.
>>
>> Of course, I don't expect that you continue working on the old approach
>> now as you have put that many efforts into the V4L2 UAPI pass-through.
>> So I think it is best to do the evolutionary changes in scope of virtio
>> video device specification, and create a new device specification
>> (virtio-v4l2 ?) for the revolutionary changes. Then I'd be glad to
>> continue the virtio-video development. In fact I already started making
>> draft v7 of the spec according to the comments. I hope it will be ready
>> for review soon.
>>
>> I hope this approach will also help fix issues with virtio-video spec
>> and driver development misalignment as well as V4L2 compliance issues
>> with the driver. I believe the problems were caused partly by poor
>> communication between us and by misalignment of our development cycles,
>> not by the driver complexity.
>>
>> So in my opinion it is OK to have different specs with overlapping
>> functionality for some time. My only concern is if this would be
>> accepted by the community and the committee. How the things usually go
>> here: preferring features and tolerating possible security issues or the
>> other way around? Also how acceptable is having linux-specific protocols
>> at all?
> My main question is: What would be something that we can merge as a
> spec, that would either cover the different use cases already, or that
> could be easily extended to cover the use cases it does not handle
> initially?
>
> For example, can some of the features that would be useful in crosvm be
> tucked behind some feature bit(s), so that the more restricted COQOS
> hypervisor would simply not offer them? (Two feature bits covering two
> different mechanisms, like the current approach and the v4l2 approach,
> would also be good, as long as there's enough common ground between the
> two.)
>
> If a staged approach (adding features controled by feature bits) would
> be possible, that would be my preferred way to do it.

Hmm, I see several ways how we can use the feature flags:
1. Basically making two feature flags: one for the current video spec
and one for the V4L2 UAPI pass through. Kind of the same as having two
different specs, but within one device. Not sure which way is better.
Probably having two separate devices would be easier to review and merge.
2. Finding a subset of V4L2, that closely matches the current draft, and
restrict everything else. A perfectly reasoned answer for this case will
require a lot of work going through all the V4L2 structures I think. And
even if we have a concrete plan, it has to be implemented first. I doubt
it is possible. Based on the things, that I already know, this is going
to be a compromise on security anyway, so we're not happy about that.
More on that below.
3. Stop trying to simply pass the V4L2 UAPI through and focus on making
the virtio video spec as close to the V4L2 UAPI as possible, but with
the appropriate security model. So that the video device can be extended
with a feature flag to something very close to full V4L2 UAPI. A lot of
work as well, I think. And this won't allow us to simply link the V4L2
UAPI in the spec and therefore reduce its size, which is Alexandre's
current goal. So Alexandre and his team are not happy this way probably.

 From the security point of view these are our goals from most to less
important AFAIU:
1. Make the device secure. If a device is compromised, the whole
physical machine is at risk. Complexity is the enemy here. It helps a
lot to make the device as straightforward and easy to implement as
possible. Therefore it is good to make the spec device/function-centric
from this PoV.
2. Ensure, that drivers are also secure at least from user-space side.
Maybe from device side too.
3. Implementing secure playback and making sure media doesn't leak. For
this case it is nice to have these object UUIDs as buffers.

Please correct me if there's something wrong here.

When we start looking from this perspective even things like naming
video buffer queues "output" for device input and "capture" for device
output are problematic. In my experience this naming scheme takes some
time and for sure several coding mistakes to get used to. Unfortunately
this can't be turned off with some feature flags. In contrast virtio
video v6 names these queues "input" and "output". This is perfectly fine
if we look from the device side. It is understandable, that Alexandre's
list of differences between V4L2 UAPI and the current state of virtio
video doesn't include these things. But we have to count them, I think.
That's why it takes me so long to make the list. :) So throwing away
this simplicity is still going to be a compromise from the security
perspective, that we're not happy about.

This is mostly because V4L2 UAPI brings a hard dependency on V4L2, its
security model, legacy, use-cases, developers, etc. It can be changed
over time, but this is a long process because this means changing the
Linux UAPI. Also this means, that nothing can be removed from it, only
added (if the V4L2 community agrees). For example, we can't simply add a
new way of sharing buffers for potential new use-cases once we switch to
V4L2 UAPI AFAIU. The V4L2 community can simply reject changes because
this is a UAPI after all. We kind of have a weak dependency already,
because the only driver implementation is based on V4L2 and we'd like to
keep the spec as close to V4L2 as possible, but it is not the same
thing. So at the moment it looks like the V4L2 UAPI proposal is not
super flexible. Alexandre said, that we can simply not implement some of
the ioctls. Well, this definitely doesn't cover all the complexity like
the structures and other subtle details.

Also adding the feature flags would probably defeat the stated purpose
of switching to V4L2 UAPI anyway: the simplicity of the spec and of the
V4L2 driver.

So I have a lot of doubts about the feasibility of adding feature flags.
If Alexandre and his team want the V4L2 UAPI as is, then looks like it
is best to simply have two specs:
1. virtio-video for those interested in building from ground up with the
security model appropriate for virtualization in mind. This is going to
take time and not going to reach feature parity with V4L2 ever I think.
I mean some old devices might never get support this way.
2. virtio-v4l2 as a shortcut for those interested in having feature
parity with V4L2 fast. Like a compatibility layer. Probably this is
going to be used in linux host + linux guest use-cases only. Maybe it
gets obsoleted by the first spec in several years for most modern use-cases=
.

Or maybe have these two cases within a single device spec as I wrote above.

This makes a lot of sense to me. If V4L2 UAPI pass through is in fact
only needed for compatibility, then this way we can avoid a lot of work
going through all of the V4L2 and trying to find different subsets or
trying to construct something, that is close to V4L2 UAPI, but doesn't
compromise on the security. I'm not really interested in doing all this
work because we're already more or less satisfied with the current
state. We don't need feature parity with V4L2. On the other hand for
Alexandre the feature-parity with V4L2 is clearly of higher priority,
than all these subtle security model differences. In my opinion it also
doesn't make sense to invest that much time in something, that looks
like a compatibility layer. So it seems both of us are interested in
avoiding all this extra work. Then I'd just prefer to have two different
specs so that everyone can work according to their priorities.


> Regarding the protocol: I think Linux-originating protocols (that can be
> implemented on non-Linux setups) are fine, Linux-only protocols probably
> not so much.

Thanks for the information. Well, it looks like the V4L2 UAPI could be
implemented on any platform unless it needs a completely new way of
memory management since all the V4L2_MEMORY_* constants are going to be
used already AFAIU.


>>>>      a. So V4L2 subsystem and the current virtio-video driver are alre=
ady
>>>> reducing the complexity. And this seems as the right place to do this,
>>>> because the complexity is caused by the amount of V4L2 use cases and i=
ts
>>>> legacy. If somebody wants to use virtio-video in a Windows guest, they
>>>> would prefer a simpler API, right? I think this use-case is not purely
>>>> abstract at all.
>>> The V4L2 subsystem is there to factorize code that can be shared
>>> between drivers and manage their internal state. Our target is the
>>> V4L2 UAPI, so a Windows driver needs not be concerned about these
>>> details - it does what it would have done with virtio-video, and just
>>> uses the V4L2 structures to communicate with the host instead of the
>>> virtio-video ones.
>> It can also reuse the virtio-video structures. So I think despite the
>> ability to reuse V4L2 structures, having to implement a linux-specific
>> interface would still be a bigger pain.
> Hm. Do the v4l2 structures drag in too many adjacent things that need to
> be implemented? Can we match the video-video structures from the current
> proposal with some v4l2 structures and extract a common wrapper for
> those that match, with a feature-bit controlled backend? It would be
> fine if any of those backends supported a slightly different subset of
> the common parts, as long as the parts implemented by both would be
> enough to implement a working device. (Mostly thinking out loud here.)

I don't think this is realistic unfortunately. On per ioctl level it is
possible to disable some functionality probably, but the V4L2 structures
are set in stone. We can only extend them.


>>> The guest driver that I wrote is, I think, a good example of the
>>> complexity you can expect in terms of guest driver size (as it is
>>> pretty functional already with its 1000 and some LoCs). For the UAPI
>>> complexity, the host device basically unpacks the information it needs
>>> and rebuilds the V4L2 structures before calling into the host device,
>>> and I don't see this process as more complex that the unpacking of
>>> virtio-video structs which we also did in crosvm.
>> Unfortunately our hypervisor doesn't support mapping random host pages
>> in the guest. Static allocations of shared memory regions are possible.
>> But then we have to tell V4L2 to allocate buffers there. Then we'll need
>> a region per virtual device. This is just very tedious and inflexible.
>> That's why we're mainly interested in having the guest pages sharing in
>> the virtio video spec.
> This really sounds like you'll want a different approach -- two
> mechanisms covered by two feature bits might indeed be the way to go.

Well, basically this is the way we have it now. I'm not sure what is
Alexandre's plan with the V4L2 UAPI approach. And if this is going to be
solved, the solution already doesn't look future-proof anyway unfortunately=
.


>>> I hope I have somehow addressed your points. The main point here is to
>>> discuss whether the V4L2 UAPI is a suitable transport for guest/host
>>> accelerated codec work, regardless of what the guest or host
>>> ultimately uses as UAPI. The goal of the PoC is to demonstrate that
>>> this is a viable solution. This PoC is largely simplified by the fact
>>> that V4L2 is used all along the way, but this is irrelevant - yes,
>>> actual devices will likely talk to other APIs and maintain more state,
>>> like a virtio-video device would do. What I want to demonstrate is
>>> that we can send encoding work and receive a valid stream, and that it
>>> is not costly, and only marginally more complex than our virtio-video
>>> spec attempts.
>>>
>>> ... and we can support cameras too, but that's just a convenient
>>> side-effect, not the ultimate solution to the camera virtualization
>>> problem (that's for the camera folks to decide).
>> Thanks for your answer!
> Thanks everyone -- do you think the "two feature bits to cover different
> approaches, but using a common infrastructure" idea could work? If yes,
> I think that's the direction we should take. If we can implement this
> with just one feature bit, that might also be a good route to extend it
> later, but I'm not familiar enough with the whole infrastructure to make
> any judgement here.

Thanks for your suggestions. Hopefully we end up with a good solution.


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

