Return-Path: <virtio-dev-return-11939-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B606C76188
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 22:39:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D8C8B42B62
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 22:39:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D1B5F98640A
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 22:39:58 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C6B059843C6; Mon,  3 Apr 2023 22:39:58 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B16749863E4;
	Mon,  3 Apr 2023 22:39:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J35mWFQrR1bA4paH/LXt2ameMy9bOcPCtiVzr33UxtWvw7XOXz9PgWzgVJqOssBWQrFzSMUEhJCIU5QAi578RHqNuHVPPBD2oq0GcuzQvRTi+E+rDAFEg3U1UpNz93giFt4guF/e0k3/zfsTrQJkNC+JFufGaLUTIJvLbgsfDlmVpscmJuMjO1jizYqMzrXXxfLIyWquddaqEYukdBaghEnnYhIDjv74Cx/WqnDl1AT4YRFai7w0B9dIIXW6HjKNyBVi19XfP40t4DemQ14pMETe+lfaRdPIz7djCIiNAySuWotk5DB6Dya1o2FyNjsR/t9D6xGGtcPhC1cZ6Y36og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqvHU+mAqZrTwuIZQEEmZSI0aqs+WpFKhCT9JUwMvI8=;
 b=F4Kn4mDNbieydneuD667yq8GmDRxe/FVMr4N5RPFsoY336LrjziWtQQBcl4fj+CUPfnmScVyi6JJO/XTH4dRl2F/duRNSqgmILxbCnFJbj9oGXvXBpPXAOq1+k8Bvf5w1kaE3t77DwLm1yoXLC9hcrBw4UeCZ2CplWw2FYCjryWqbKCw0SGkfiWNnfz2iNttes5ksZN7nNJ2l+i2PIYrsBvRu0LK2yJyBAdKaqQJy6fxjIU9SBG20lOtsp7vEqrViUWWHDfPEpUvaZALdA25D/Hch1WuhhQ1GCWWLCXang+ZekgrHcDupoX5J/rTaFX1Nklb/MqmdWxcYE3PgfJSQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>,
	"mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "pasic@linux.ibm.com"
	<pasic@linux.ibm.com>, "cohuck@redhat.com" <cohuck@redhat.com>
Thread-Topic: [virtio-comment] [PATCH 0/3] transport-pci: msix summary update
Thread-Index: AQHZXfD9dpJsEwQYP0ewg+8+kuo6/68OKWmAgAwUyXA=
Date: Mon, 3 Apr 2023 22:39:44 +0000
Message-ID:
 <DM8PR12MB54802EF9E32D78394A233231DC929@DM8PR12MB5480.namprd12.prod.outlook.com>
References: <20230324013534.280820-1-parav@nvidia.com>
 <1679897351.7097778-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1679897351.7097778-1-xuanzhuo@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5480:EE_|BN9PR12MB5241:EE_
x-ms-office365-filtering-correlation-id: 7cddedb8-1175-4c71-ef40-08db34945289
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6MPCSidiE6WmK9KAdv4YN1v79PQIs6D4XIluvxSn0uN/9LXeYElTLft7Anp/pNVB9FkA+fqVcc7QaXlkhfEugHhQGISe8byACSa2HTbba0ZqBnlIw8cYtBmcN58Kg9ieZzmVCqKebJQQtGB0DM2kxdFcoDWPz34GWNVJhscSQZ9TpKNiCrtuTWXbADquUa3u431MRvf1+HQ2t6GICWOvHAN6auHS3+s6g9q9hzb38hhE2uStAvgvlMiwMEkFv8uxqsvRc4OYQW9EU/iVm9q/30qiqF7OqbjHSJdiZsbWgpJ/MtIf1cpZXh5qi9xSQf/dFSSXkZpT7pxen2G+5iceIocyu7ewIOIjSViOzn/vmDm104zmePP6FPDaUaGJSe8PPe6tTalSk0ltWsKSnAoSoxA9eaPuqPbxEqSumHJO1Cj+9MoiEc0S8zBorvUDmsvBBw2PEZ77H7X5H/P2lobmFxbssa0+vk3RMktrtePowAYnyBvpFKKm8ueKE5v2UV0DsCBEZYUuhKQU3I1cvlgNf7+Bxpwfj308eb3TwSSLXxfuq3m9UNDUzn16fOQ4ENBlu37hqroId6g7/PAU/GBxVGt8u79rAJd+HTW5H9dhnWV0SjOXUTHkIElS/BIeNF1244dmvU6QB1Fj4qQrrmqVaBOpRJuKHH88+aOeTlX0rrUqpCIGvnTgVbS3c7YavHr2
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5480.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(451199021)(186003)(66899021)(9686003)(6506007)(26005)(55016003)(33656002)(54906003)(478600001)(71200400001)(7696005)(38100700002)(15650500001)(66556008)(86362001)(66946007)(66446008)(66476007)(316002)(76116006)(64756008)(83380400001)(4326008)(6916009)(8676002)(122000001)(2906002)(41300700001)(5660300002)(52536014)(966005)(8936002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TSJsjPUcv53fUQtsXcA8m9JMmyC1NosEq0alPNq+wuW3UHMJfofNVAWrPlWO?=
 =?us-ascii?Q?ugeBcJQTPSrFRa9OckVoz7uUGE5Ve4HhE2aUAEFiMcXCK1G3ull0I9FHkb8k?=
 =?us-ascii?Q?L/y4vv7DEAAsxDoLbjzF6wSuGtKKCJeUMg08Q5nIa7dipx03PovBpsqCEyd2?=
 =?us-ascii?Q?197UDoFXH1omnYOPxeW10o85m5HGfeGMCX8FjocHs2528f+3GIYuculENp4+?=
 =?us-ascii?Q?CcnMfXBjy+IekM7zEINUdqQ8ymTf1W/ZVZ41HUNgAbtA2XhRdPbXmXdmX3cZ?=
 =?us-ascii?Q?YSZ8n7wXuKfB6ZI/GPShHWGEWdiFx37VDYKSejjFs/QIECJo0uWD9LJb43dm?=
 =?us-ascii?Q?v56B6QcAcI1H8El4yclzXbhwe+z9ueOVpNydrm8fXCaDmgea8nNZWP/UYLql?=
 =?us-ascii?Q?Gi9WSSFC7W9EWa40eIrKNymLv7VzBvbCCVuF8TRnM7bqNLfNZSU6DzkL5rXc?=
 =?us-ascii?Q?GG5CoqzhOhmDkmIVv+Knw3XieAJ0oGCLZUG8//hvv44ZJEK1c5l2/EjDdjA6?=
 =?us-ascii?Q?RNsfBgfrX9qV72Jz4oIirVXW169LMDjORfTkfoM4j7iOk+QO2CPHnTI6t/TR?=
 =?us-ascii?Q?utr2TJSKjS7w32+qvc0ENf6cyUEdLjYnQ2YgraVCmeJ0S9k4SLKD5LwilEw7?=
 =?us-ascii?Q?ldk8ZLVxxufUR+oy2UdH1CMSAQBo7r8IWH632wZaixh9t+5X6Z7hjP41DBoD?=
 =?us-ascii?Q?JPus1gu3q2Ltn4SdBcusBhy3Dn/w861xVlwaN5srdCXyj29+lefW8wnvq0C3?=
 =?us-ascii?Q?N+PgA4y7XREne0ASHVsEQYLKOZYuIgYCzlWG2CkKP5oPnJFWZ+thjgQ1FG3G?=
 =?us-ascii?Q?vVsx74j5bpELZ9Rka9YXY4Tb0HU7hODgiV5WsUGNSfEOi0U51oHX9Qdlqunb?=
 =?us-ascii?Q?qUnJ+kGGQjkhXu+zOvvVAO/hlvZmF493RyxcAS6S/22Ih7Oglad+s2DZLtHx?=
 =?us-ascii?Q?ybX1dAgl9SOsUK/imyMUlOCVSb1HDoYQj7A/E5RUlIaimR/pZFaJNOeH0Tbr?=
 =?us-ascii?Q?ZGnR/zOlccLZveHrkaJZ01ItYY++ZHbwoSiORLX64n+/PWuuSd460yCI50gN?=
 =?us-ascii?Q?aZBemcBTKC0sGz6sNYZjjK0ViznoTglWWSOl45aSG78TD6e4mo52Y5G5DR7F?=
 =?us-ascii?Q?Pt0BFrAT0vG/r7zJDVNcIakqUTnO2Y4VM2fOV9Y6mXjwdcUIEstPofnIUKwi?=
 =?us-ascii?Q?B0hgMTZilWsqmBtbPT0YVnpP5i7rb1FNCxqjAeNl70KJ10AxvRyklbf8oNzb?=
 =?us-ascii?Q?yfDaaz0/WyBUhNeK7pBp5fFarCqiD6BfPWtB2ba0jSSZJYDQ67aNqRPMthgm?=
 =?us-ascii?Q?y8Mzr7R3SenoKjuBpCsIUMdgtBwNuwhpOjrYzqoq+8eIYwnZZ+T1PtQP8gc8?=
 =?us-ascii?Q?ka8yVJOcvGsO9LRc1kXQWT6iar1pOwmUF0I8vemsa3FGIr12jjfnPe9VPv9g?=
 =?us-ascii?Q?bJAluvzOg9dVyLtVnKwnCA1Qpo4biIXf7XH1jS1sItnk9vOeGMCNr4+lK/XC?=
 =?us-ascii?Q?G5lWT9WR2PqtdztOqkMlfGsl73aNhm5iR0W9dIDoKHgXaovVLI9gj3+qvtpZ?=
 =?us-ascii?Q?M3fNvbX2aOdEpss+KdI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5480.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cddedb8-1175-4c71-ef40-08db34945289
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 22:39:44.7276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5fnD5+KDje2yIb9hjGa526vBioBOAv4BhQw29oJdkVEHGqJqMHQvI4oup9dGaD+BVpuAgYdm2z8pz3XMxLtZ5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5241
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 0/3] transport-pci: msix summary update

Hi Cornelia,

> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Monday, March 27, 2023 2:09 AM
> Series:
>=20
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>=20

It is editorial change rewording the text.
Can you please take this short series forward?

> On Fri, 24 Mar 2023 04:35:31 +0300, Parav Pandit <parav@nvidia.com> wrote=
:
> > Summary for config_msix_vector and queue_msix_vector registers have a
> > confusing text of "for MSI-X".
> >
> > Rewrite the register summary line.
> >
> > Patch summary:
> > patch 1 removes empty line at the end of the file patch 2 updates
> > configuration vector summary patch 3 updates queue vector summary
> >
> > These are only editorial changes to rewrite the summary.
> > Hence it should not require a github issue.
> >
> > Parav Pandit (3):
> >   transport-pci: Remove empty line at end of file
> >   transport-pci: Improve config msix vector description
> >   transport-pci: Improve queue msix vector register desc
> >
> >  transport-pci.tex | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > --
> > 2.26.2
> >
> >
> > This publicly archived list offers a means to provide input to the
> > OASIS Virtual I/O Device (VIRTIO) TC.
> >
> > In order to verify user consent to the Feedback License terms and to
> > minimize spam in the list archive, subscription is required before
> > posting.
> >
> > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > List help: virtio-comment-help@lists.oasis-open.org
> > List archive: https://lists.oasis-open.org/archives/virtio-comment/
> > Feedback License:
> > https://www.oasis-open.org/who/ipr/feedback_license.pdf
> > List Guidelines:
> > https://www.oasis-open.org/policies-guidelines/mailing-lists
> > Committee: https://www.oasis-open.org/committees/virtio/
> > Join OASIS: https://www.oasis-open.org/join/
> >

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

