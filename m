Return-Path: <virtio-dev-return-12451-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC685C77B7C
	for <virtio-dev@archiver.kernel.org>; Thu, 27 Apr 2023 14:20:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 12B742AEDC
	for <virtio-dev@archiver.kernel.org>; Thu, 27 Apr 2023 14:20:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E2AE898664C
	for <virtio-dev@archiver.kernel.org>; Thu, 27 Apr 2023 14:20:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BD57B986644; Thu, 27 Apr 2023 14:20:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 67C51986646
	for <virtio-dev@lists.oasis-open.org>; Thu, 27 Apr 2023 14:20:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1682605212.707000
X-TM-MAIL-UUID: 376967d6-0364-49aa-9a10-4f9ca2f520e8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/VVL5/UtXyosJCAAMZG1bOi9eDvlVXFINwkqxGnimWYbT288OpHuAyeYP5DOmynx6liycdz5L+2iNbPaJQbRTRaDlaAwM6xohjKGPQ/EXe6QwImt9+PW5b8c5U/LK2IUxHEZNW9RJ6HbVDH/NcYK+tVRyQgOsVWaiWeW0ShVMYFX1nFojietFC5MyhcPMXygJVldjMjOqRY7UgR3MWW19dSrRj0rdAriT59llek8T2ylQOo7m42CGplZNdZT44ej4AGIYPAmbkmGi7+VMcgeYmp9g8FdzBxgyZRkkXu5FyCbusdvavpwECxEIDXWLqmxgvra0DXPb2irrypmA1ehg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6VKM7S7g417nSmUT0HnUXiqQMZCsrFK1HYb7wlsh5g=;
 b=oK7lfVwWLm4ez+lTGrnTSg9h09mlhzexmlnvto6chyDrLfPdkSLhWKWBQEzqTn4qdAkXZKWFAfl0N3C8hWR+0hdj27RuzwTHXxOLauVQM75zUAmKvH61u/Vc/OKUeTWZWVd+oWcnPUAeZBUgZHwIpfbrmA4gm96ikkueLFy0GxRpzWUR2DLqdfAhUe/jfEQwltQhY6tZf3hzdLP+H9N/78ZhJeocLWypuijBdoeNbE4Xg1ZaSeB/ETPBXdktF4q/83MQ53BmE+j52qo/0VyeMaCOidZZ7lI72QBVp1IbT6xY2ndxvpcm9tpLJCSSgSe0T5k6JnHOzq16FUxHmS7vTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <b2d78c20-8476-ccda-42ca-6863f44b06ed@opensynergy.com>
Date: Thu, 27 Apr 2023 16:20:09 +0200
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
 <590378d1-83e0-b058-7eeb-2dbe5963670e@opensynergy.com>
 <CAPBb6MWMjvTiAdCwfUH62EpqYLHotFoDg7hAfqY2oLkpmYM_HQ@mail.gmail.com>
From: Alexander Gordeev <alexander.gordeev@opensynergy.com>
In-Reply-To: <CAPBb6MWMjvTiAdCwfUH62EpqYLHotFoDg7hAfqY2oLkpmYM_HQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE1P281CA0248.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8b::10) To BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:4d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2663:EE_|BE1P281MB3127:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a206ad3-fb8f-4777-57bf-08db472a8296
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rhPc3S2iuS6hRiewAp3GMduTpDLpE2ldwBdn1EE3Ft+o4Hqxbh2q5SApwo2O7xRB14uiW4Du/2+V7RjyqXwQFVcd0yDx07MDildwawlQCSH90bbevP0yooH6YRAP8OKK16CB08bZOkd1YYpWi3i3msUEyoIW1BjzNJpf1933p6zNjJouwgAOfABSpIP/HOHYo3J8Fqt2HZy/iD3S8bOVE9mT2VL1jAJtVRf0nZrASQUoDL3ELarbbRoqXMzQoL2NMsS7cDQFjLp9TKjHFAK3BgW+8Bd5m6BHnfYQP5AyNSCbH1zGzkjOFRc2C2IpO720fsVzb7e2z32t/Su3Vss3j2nYdoh9ZnmXXLayggVQmhGo+YKcL2zooHybengEF+OLr2eLnAD31m22IXl2S6v//nE1f+uo5M3a4WF+kozLPWGi+TjDYHIHrSAZOyX/xmN9vusuTWFxYpD1DG2rtS7GTV/LZzGQT09cfDBxh2J4niX3et6lp2ArBrUzZYlTqgtLn7qcMrs30wak4rGIulXvua2ZaztcwhGSvoDGACrJSrmxnfGpkgutwkLm0q3mq8tMifAfFOiA241PpDIG9UScJfQ6pTRwEDSvFcgdC6XzXtLpUD/92uozhE/pQlceN+Rw1WB2qgqRZ+4994dHz12Hxg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(366004)(39840400004)(396003)(451199021)(66899021)(316002)(4326008)(66476007)(66946007)(66556008)(6916009)(42186006)(54906003)(966005)(15974865002)(86362001)(31696002)(478600001)(36756003)(186003)(53546011)(26005)(41300700001)(66574015)(38100700002)(2616005)(30864003)(2906002)(31686004)(5660300002)(44832011)(8936002)(83380400001)(7416002)(8676002)(5930299015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0lteWFURk1VSWFWRE1WR0htSEgrYjNzYnJ1U3k2Z1lHRXVhYWZNak0wdkhK?=
 =?utf-8?B?K284cHlGMnRwb0ZJanRBUnFGQlEzOVV3Mk5aUUJLOWhTMWwvdDNMRHE2L3NM?=
 =?utf-8?B?cWt6UFA2dGZaMzRSYTBvRUYvM1NONEprZWR5MmxhZVg1NStEcytSN0hUR0NH?=
 =?utf-8?B?MEh3K0tkL1ROQmw1YTRqT2JVTElRZStoTzJkenUrS2lteWtZaUFmK1IyUUJk?=
 =?utf-8?B?NExUOExNNlVtY0ZyOWtQN0FzdnBqc0lRcSt4VVZoZ2pyYjBrOGhYWGxrZEJr?=
 =?utf-8?B?dXNnaDBIN09ZNWI1TUVLcWZsVVBlWWFjbUtyYy9aZlh0aDlJS01NYmdqMCtx?=
 =?utf-8?B?d0VYNEQ5cUY3OGc2KzRSREFWcStZQ3pUNDZ6NEdnbHZBU2hPall1K3BTMXdt?=
 =?utf-8?B?WjhOOHFLeW5yUEF1VllONkZabHpnMXJ4ZWNqSjkwNUZlc2UzZ2VqQ0hKb3pG?=
 =?utf-8?B?RTY0bjZYb1VxNWFQZ0NPbTJicUdyU3NRSGp6b2kxald1dWV4UVRpRGVhQjVa?=
 =?utf-8?B?OHZjYVBNL2FzclBVU0RGU3g5bU85eXdRVmtYdHJrRUIvaHR6ZlluaERXaTlh?=
 =?utf-8?B?aGlvOFFHWStwcHpKNVhrck5LVXFqM1hpNXIxZUltR3pha3IyL1pTbDN5UEN2?=
 =?utf-8?B?Q2tvZkRtcEJ2MVQ4Z3E4RzRvK2Y0bFVPTnhXTGR3WkZWMktNd2lCd21Fd0t2?=
 =?utf-8?B?K3R5em9yZlh2QzB1aEdVVklndmVrN2t5TVVEMGx2QWhkOWo5aXBlU0hKQ3c5?=
 =?utf-8?B?MkdYNWZ3eDAwNVZlVkpUSXBId1ExU3RqeEQrK3AvTW96N2Y5WjJXczlySFE4?=
 =?utf-8?B?ZFZLbUdqV0JTcUthbFRHd2x3aitWTFRDMk91Y21uWERiR21XSWsxMWFWWmpl?=
 =?utf-8?B?TFBVNGpSaW5MbVhlUStJZVdVREtkOTYyM3dJZTNHTFNJeGxrL0NRNC9iWjEv?=
 =?utf-8?B?RHcyZm1XdS9CNDJ4TmQ0Tmp4UG5YTzU0TzVmK1pjczBzZzY4NFlmVDZwQTJz?=
 =?utf-8?B?RjBVMVp3bnRYQnBDNXpOMkhCOXJsVlhBR3ErQnVtbHFoUDVXQmM5WmRRaElz?=
 =?utf-8?B?K08zcHRzK2FTRHM1TzdSb1lYc3NXZ2hyTGVYZFV4WE1QV0FVOXlVMkdqL0xr?=
 =?utf-8?B?eDJ3a3RaNHppQzE4NHo5a3lLY0xiYzdkWEFwdStiSzZxVTZwK21WZ2cvQVZO?=
 =?utf-8?B?bldPOUdvcE40ZGNPUjduMEJZQlFJam9uNUpqYjRJRUh2eW5CWWZySHNFcXZX?=
 =?utf-8?B?cVYwRzE4TmtZN1ladllHWTYxMVVuQ1VhZElZTzZEZDA1dDlYaWIraWUzYlYy?=
 =?utf-8?B?aEhKYkxEcSsyb1hTd2hIRWJEbGNXUlZMRDRFSWwxV2ZkWkVkbVIwMzFIS20r?=
 =?utf-8?B?d2lyYkpTcVkwUGNwaUJwZDlDTndGM0J0WDN4eW5kMzRMWTN2TGpGNmp0MGFK?=
 =?utf-8?B?Q1JZUUNDMWYyMmpLU3lyL01SQ2o1UFNYdG0vcmd4R2RNa0JwV3ZkMkg1Uldh?=
 =?utf-8?B?WXkrbjQ2QVRVUXlKZ0pwblV1dmRCaCtjRW96cm5jK0VMQlQ3WjdaQVZrZUV4?=
 =?utf-8?B?U1FsazJwa0xiKzl5ZXZKTHZ0dHhUWFN1Tlg3d2I3TElERXJvVy9nMGpYdFBD?=
 =?utf-8?B?NFEyK3ZIQ3FHaXNxR1hIUlM0c09UVUpRcjZDYUpYNWlIZTlNZE83WVJ3SUJK?=
 =?utf-8?B?dnJxak43UUR3eFd3dkJwejlOVW9iTFBPcWMwYm5RMHEwSGxxU3dhcjdHK0RY?=
 =?utf-8?B?R2UvV0c4N3I0WjFtS0FKbW03RDcwakFCMVUvSmk1RFczdE1Id0haRXdSdDNt?=
 =?utf-8?B?R2lQdDM4aGpIaVNHeTVKVnl3akxCeTdlbFI4NVhVNmN3MFNVWGo2N0M5OXIx?=
 =?utf-8?B?cFByWElCNHh3VXM2Rk5vREpNMlloaFNDUnExNHJuQ01mc1pJbUNLSUZYV3ZB?=
 =?utf-8?B?RGtVelhjeXNRVExPQ25VclhwSmxpWUZiZDhaRkpyanJpNHRtMkhmQS9aUVlY?=
 =?utf-8?B?QmJicnFoUHREV2ZCbU05NHV1dXFyUmM2NWppQ1IrNERhOGZ0UWw0VlMzd3oz?=
 =?utf-8?B?TDhRRFZaQXFqdVZwRWVkdlpVT1pWSWIvZFRhQkVDbWFRM1ZDcWRCcWZRdGxW?=
 =?utf-8?Q?U9aG9kVvLKArAGZRS4OurrqBe?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a206ad3-fb8f-4777-57bf-08db472a8296
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 14:20:10.9970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K72WJjup6NqriCnf33OtyN68Wwq4z0b6XaNix87iekBFmMjrl5ZTEYvPf8o1+DniDAAROAMubySvGvInK0JyNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB3127
X-TM-AS-ERS: 104.47.11.176-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1007-27592.000
X-TMASE-Result: 10--28.527900-4.000000
X-TMASE-MatchedRID: IeZYkn8zfFr/9O/B1c/Qy6n9fPsu8s0a9mojSc/N3Qc0C8Dp8kkTtehN
	0jwIx2vHYGK3LJXf9mNkXWktuhCgQvd1SWcwQUIOn6y0mNkW0aQ10wJPYcToKEneIilVX/rqk66
	/gtVjZsXOSDPNwDqJeAD2Qb9HgeXyvxpbh9elAJ0zoDR4ZVO2DARryDXHx6oXhg/Tt7otYdgIyZ
	Ynq1RP52s+Dz00KoL2WbOLpgv9C7apy+eDOQsxEFcgCgDL49aaULuzkowEEtpSMvn7ehGotklMt
	+G3BRybF8w4pXnSlT58kvfy7VW07t/K1ikJIsLOOGTV4fFD6yAjcJ6VBRs0HFhbZQcXLzLf90ib
	xL4bz6BeKiBY7piwiBsrhSdUWpXHmf21d+GoFWzGsO9QyW2iBKVjgXyvS9c/PHMAbjuhwd9zCGq
	Wg6PTinsxI/tIum4YjYbQU0iVlK8m2WWAELvR+R7hLNOPFFWiNmVjpriVEtl1HYgAgz5GJShd/M
	bd1bBoNhlKKwjLwp7PYHNZ/BmJazsgePJmZUOfNcoW2wO1ntNx4XRZg8mla/P2659hRKRR6WkO5
	pRtxMD0zdEdzHUxnxevMnLENyDpdnn0aUty3+UFxov+3JYvYzqu3dM+YhFRsLigDA/FpvXZKLf/
	ti2lVIS/T4qLg53oMTqMsSzDIRGaYlNpIKBgCyrLqyE6Ur/jcWZEfrt7JgVa01qA/Hb6wEn0vje
	eb/bZs1lTliPiUoeNjKy+fkrJaooQQQ8njMLsB7AFWMPZIMaUO3k9AyCPTeTAwJX5xURqujVRkD
	gmq7PhA54Xxl0CK1uvVyEtOhoPEHR5W0xTkI1+yskgwrfsC30tCKdnhB581B0Hk1Q1KyLgfCfWl
	nNb/1cppCzPq+1UkGUtrowrXLg=
X-TMASE-XGENCLOUD: 59d1d870-b12f-4d4e-a4c9-54171dedc394-0-0-200-0
X-TM-Deliver-Signature: C3D0A344D966A43CAE9E4BBCCB3D0CD6
X-TM-Addin-Auth: /+TQxJHjIV3L+m8owLV26KqunY51bvMm3m5Zd1hRXLlmh1SSlWPaUxGVqnv
	v8cBZjXOKRdepvpgU8H4uu+uri2BP0GRzig+gIVA6aOb18y2Rb5XzE6Kh7lK9DAv+Z+cZe/c70x
	JCZ7Hizpfs5JTfIEOWuUCzsTAzIyYMJx+kgLt590VoDLwXn9KzhemH92WoRNFuhUlqN3ex24yQ5
	pl/UldMXnI0XsNv+QiXNNWBFgflkKiKLkweW/LsR0L3wE3xydgZbhhNG8t3dHrpUENDd/vsD2hU
	KauELLFOmSwj0Do=.qw0wlAPkkHg1Gss37LPK283nNMIiw2MYX5zdq0X2UWHVRT5+9tyKek29CC
	eBHRZD3cqPYaMN0IRtC7jQxC4TYskoyK171b5VJM6VndL0gApGyXySgKOenVQ62eN3xClb1N3wb
	65plZp5CPc84/NwHGzHCPCJ51G5lx8kcd1vnZb9WXxQIBO72jRBoe8rH9XNPBhTcClWHuaevwbA
	vjEJRQfsQITRz+XdyMJcK/3bjtRIpJaMFYKe5gQZ1296gH11sD3pfzZmYtPPf66apMnZIjtlFSf
	khwi4Etkiu3S0bzc2XiQJijn947YXgovI1qlnWWwpArJG+iW2iyXSFGe+6w==
X-TM-Addin-ProductCode: EMS
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification

On 26.04.23 07:52, Alexandre Courbot wrote:
> On Mon, Apr 24, 2023 at 4:52=E2=80=AFPM Alexander Gordeev
> <alexander.gordeev@opensynergy.com> wrote:
>>
>> On 21.04.23 18:01, Alexander Gordeev wrote:
>>
>>> On 21.04.23 06:02, Alexandre Courbot wrote:
>>>
>>>> * I am still not convinced that V4L2 is lacking from a security
>>>> perspective. It would take just one valid example to change my mind
>>>> (and no, the way the queues are named is not valid). And btw, if it
>>>> really introduces security issues, then this makes it invalid for
>>>> inclusion in virtio entirely, just not OpSy's hypervisor.
>>>
>>>
>>> I'd like to start with this and then answer everything else later.
>>>
>>> Let's compare VIRTIO_VIDEO_CMD_RESOURCE_QUEUE with
>>> VIDIOC_QBUF+VIDIOC_DQBUF. Including the parameters, of course. First,
>>> let's compare the word count to get a very rough estimate of complexity=
.
>>> I counted 585 words for VIRTIO_VIDEO_CMD_RESOURCE_QUEUE, including the
>>> parameters. VIDIOC_QBUF+VIDIOC_DQBUF are defined together and take 1206
>>> words, they both use struct v4l2_buffer as a parameter. The struct take=
s
>>> 2716 words to be described. So the whole thing takes 3922 words. This i=
s
>>> 6.7 times more, than VIRTIO_VIDEO_CMD_RESOURCE_QUEUE. If we check the
>>> definitions of the structs, it is also very obvious, that V4L2 UAPI is
>>> almost like an order of magnitude more complex.
>>
>>
>> I think, it is best to add all the steps necessary to reproduce my calcu=
lations just in case.
>>
>> VIRTIO_VIDEO_CMD_RESOURCE_QUEUE is doing essentially the same thing as V=
IDIOC_QBUF+VIDIOC_DQBUF, so we're comparing apples to apples (if we don't f=
orget to compare their parameters too).
>>
>> To get the word count for the VIRTIO_VIDEO_CMD_RESOURCE_QUEUE I opened t=
he rendered PDF of video section only from the first email in this thread. =
Here is the link: https://drive.google.com/file/d/1Sm6LSqvKqQiwYmDE9BXZ0po3=
XTKnKYlD/view?usp=3Dsharing . Then I scrolled to page 11 and copied everyth=
ing related a text file. This is around two pages in the PDF. Then I remove=
d page numbers from the copied text and used 'wc -w' to count words.
>>
>> To get the word count for VIDIOC_QBUF+VIDIOC_DQBUF I opened this link: h=
ttps://docs.kernel.org/userspace-api/media/v4l/vidioc-qbuf.html . Then I se=
lected all the text except table of contents and did followed the same proc=
edure.
>>
>> To get the word count for struct v4l2_buffer and other types, that are r=
eferenced from it, I opened this link: https://docs.kernel.org/userspace-ap=
i/media/v4l/buffer.html#struct-v4l2-buffer . Then I selected all the text e=
xcept the table of contents and the text above struct v4l2_buffer definitio=
n. The rest is the same.
>>
>> Also it's quite obvious if you look at them how much bigger struct v4l2_=
buffer (including the referenced types) is compared to struct virtio_video_=
resource_queue.
>
> You are comparing not the complexity of the structures but the
> verbosity of their documentation, which are written in a different
> style, format, and by different people.

I agree to some extent. At least this benchmark is simple and it
provokes to actually go and look at the definitions, which IMO should be
enough to already see the difference. What could be a better benchmark?
Maybe counting the number of various fields and flags and enum cases,
that one has to read through?

> And the V4L2 page also
> contains the description of memory types, which is part of another
> section in the virtio-video spec.

You mean only enum v4l2_memory? Or anything else too?

> There is no way to draw a meaningful
> conclusion from this.
>
> If you want to compare, do it with how the structures are actually
> used. Here is how you would queue an input buffer with virtio-video:
>
>    struct virtio_video_resource_queue queue_buf =3D {
>        .cmd_type =3D VIRTIO_VIDEO_CMD_RESOURCE_QUEUE,
>        .stream_id =3D 42,
>        .queue_type =3D VIRTIO_VIDEO_QUEUE_TYPE_INPUT,
>        .resource_id =3D 1,
>        .timestamp =3D 0x10,
>        .data_sizes =3D {
>          [0] =3D 0x1000,
>        },
>    };
>
> Now the same with virtio-v4l2:
>
>    struct virtio_v4l2_queue_buf queue_buf =3D {
>        .cmd =3D VIRTIO_V4L2_CMD_IOCTL,
>        .code =3D VIDIOC_QBUF,
>        .session_id =3D 42,
>        .buffer.type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
>        .buffer.index =3D 1,
>        .buffer.timestamp.tv_usec =3D 0x10,
>        .buffer.memory =3D V4L2_MEMORY_MMAP,
>        .planes =3D {
>          [0] =3D { .bytesused =3D 0x1000 },
>        }
>    };
>
> In both cases, you pass a structure with some members set, and the
> rest to 0. The host receives basically the same thing - it's the same
> data! The only difference is how it is laid out.

How do I know this from the text? How do I verify, that this is correct?
Can I be sure this code is going to work or not between any device and
any driver?

With virtio-video you can just go to the spec/header file, take the
struct definition and simply set all the fields.

With V4L2 UAPI I don't see any other way except going through the whole
buffer.html file, filtering potentially irrelevant stuff, then doing
some trials, and maybe looking into the device or driver code. Maybe
also asking you for an advice?
I think it is worth trying to imagine you're a newcomer in the project.
Or a security auditor.

So I think we can't draw conclusions about the spec quality from these
code samples.

> Also as mentioned by Bart, the apparent simplicity of
> VIRTIO_VIDEO_CMD_RESOURCE_QUEUE, which does not require a dequeue
> operation as the dequeue is sent with its response, is actually a
> fallacy: that design choice makes the specification simpler, but at
> the cost of more complexity on the device side and the potential to
> starve on command descriptors. By contrast, adopting the V4L2 model
> resulted in simpler code on both sides and no possibility to deadlock.
> That point could be addressed by revising the virtio-video spec, but
> then you get even closer to V4L2.

Hmm, I understand, thanks. Well, I can fix this in the spec. I have some
ideas. I think I'd better describe them in an answer to Bart's email.

>> Do we agree now, that V4L2 UAPI is not only marginally more complex?
>
> No, and I rest my case on the code samples above.
>
>>>
>>>
>>> Also please read:
>>>
>>> https://medium.com/starting-up-security/evidence-of-absence-8148958da09=
2
>>>
>>
>> This reference probably needs a clarification. You argued, that V4L2 has=
 a good track record so far. Here is the quote:
>>
>>> FWIW V4L2 has been in use for a looong time (including in Chromebooks
>>> that do secure playback) and I am not aware of fundamental security
>>> issues with it.
>>
>> But absence of found major security issues doesn't tell us much about th=
e number of not found ones. Absence of evidence is not an evidence of absen=
ce. At the link above a former Director of Security at Facebook shares his =
thoughts about what could be a good evidence of absence of major security p=
roblems.
>
> You are just FUDing now.

These are well established security concepts AFAIK. Are you gaslighting?

> The exact same argument could be made about
> virtio-video. If you want to borrow from the security world, I can ask
> you how going with virtio-video when V4L2 exists is different from
> rolling your own crypto.

It is very different because obviously neither of them is a crypto.

>> So a bug bounty program with high premiums that covers V4L2 would be a b=
etter argument in favor of *already written code* in my opinion. Not for ne=
w code. Also probably it is also an argument in favor of the spec, that is =
the V4L2 UAPI. Like that it is polished enough. Not so sure about that thou=
gh.
>>
>> There actually are several bug bounty programs, that cover the kernel. T=
hese are Google's kctf, ZDI's pwn2own, and zerodium AFAIK. However the prem=
iums are not even close to the ones mentioned in my reference. Anyway this =
means, that using *the existing V4L2 code in the kernel* is probably OK. Bu=
t this creates some limitations if we want the actual code to still be cove=
red with these bug bounties, right? This means, that the host OS has to be =
Linux and the actual hardware has to be exposed through a stable V4L2 drive=
r, that is in mainline for some time, and there has to be no or little proc=
essing on top. For us this is not possible unfortunately. In the end both t=
hings could be secure:
>>
>> 1. V4L2 pass through can be secure because of the bug bounty programs an=
d a lot of attention to the kernel in general.
>> 2. For the new code this doesn't work, so the spec should be as simple a=
nd device-centric as possible. Because, all other things being equal, there=
 are fewer errors in simpler programs. So defining a subset of V4L2 UAPI in=
cluding the data types looks like a good idea to me. The stateful decoder i=
nterface, that you point to, does not define a subset in the data types.
>
> Wouldn't you have exactly the same problem by using a new guest-host
> protocol?

I think this is far-fetched. Especially if our new protocol is
intentionally kept close to the reference protocol with a few things
made better and simpler. That would be my preferred route.

> Are you going to start a bounty program for virtio-video to
> get an assurance that it is secure?

I'm not sure it is possible because the device is proprietary. At least
the driver is going to be covered hopefully. So for the device we're
going to rely on simplicity, tests and audits. But who knows. I'm not
the one to make this decision.

>> This is basically my reasoning.
>>
>> Also these two specs don't need to compete with each other. They have di=
fferent limitations and they are for different audiences. If you check the =
XKCD's comic, it is about competing standards.
>
> They allow exactly the same thing (virtualization of video
> decoding/encoding) and there isn't any use-case of virtio-video that
> could not be covered equally well by V4L2. Reinventing a new video
> specification is pointless and will lead to unneeded fragmentation.

I don't agree with these statements.

> We should also expect reticence from the Linux community to upstream
> two virtual video drivers that basically do the same thing.

This is hypothetical.

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

