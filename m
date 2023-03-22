Return-Path: <virtio-dev-return-11719-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E38C7C6FD1C
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 16:58:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 466F32A882
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 16:58:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3A1519864A4
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 16:58:23 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2EE71986451; Wed, 22 Mar 2023 16:58:23 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1AE66986450;
	Wed, 22 Mar 2023 16:58:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOtaufLxu9QXgzWub8gXOK4zyo+IS/OJDP/oiWbEi3Z8OGJtQUhLBWrgrFpS9DSVI27JEipUcgB96jp/gZPkUBY4J54XXng1UK4OqjRw3jCM+Eh9m7jGveHh5kxD6K7v0MRrz4/EG6Q1MR6E/VwJwdR7chiMotLkeL3GfEuWugqqFJyIxIFLp9/If7CdaqCyNjY7TGyHBI/nGSiPSJrAJQ4630DkKRhxwqrROJ7bTF7TYgWqQn+GewJgTyDmPfVb5HsYhmB6pZt/7GliQKkqcQOF2D6bPLFG+rlmwSLw0aCF1edrZwh04d7pSadls8HFYMh6aC6+C3gw0zEa44E8Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQL2MpG0r/NYnYL2+H7pKSwFmkQrr7PfapkN3+p/YHc=;
 b=Fs5IKT58hbRiOJWYtkmOSOkR+mEDSH1z1W3hV9Y6+d4220oFWz1lti20vcefe3EdYtOJdSu0dDa9BTkzx13ffR6DfxqqkWHTR1+xP6SPPZLScVO6bzzy1tPgh/IZiLrPX89oXEz1KdPJsuFd9vCmOqczbfAeBCsJtlCxDPxt7VqI4Ev+4LUbQb8w83CbFSSxQNjEFByDhK3WDpa/Tcn4UTWwmkrEq6uBlxe9487mienrdTwOmA79x5L6xO3uBohVS08V5VPdbWcXWNuICtqOtg5DKvRRvzW+PwLcyfTeMBSylcwqrycPBVI+lsODeuGsEY1R9M0X+daWBDdx8kO2/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v3 6/8] transport-ccw: Refer to the vq by its number
Thread-Index:
 AQHZXEBgSCtJtVXRPkiej6PDk45tcq8FzniAgABHowCAABUDgIAA10cwgAADVgCAAAB/AA==
Date: Wed, 22 Mar 2023 16:58:17 +0000
Message-ID:
 <PH0PR12MB548134FC4E598177806AF97BDC869@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230321215834.225856-1-parav@nvidia.com>
 <20230321215834.225856-7-parav@nvidia.com>
 <20230321181704-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D1A39CACD02A2BBD4721DC869@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230321234626-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548115757F72BB333651C1D8DC869@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230322125354-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230322125354-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB8016:EE_
x-ms-office365-filtering-correlation-id: 1d11f840-aa3e-434e-93b1-08db2af6a1ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LBfghz8rUxo9ebXF+t0jkDDdSdG7G3JyJrA4KVqWjnPLSD0amVdA9msfF+00++t3VPoe+ORf0sTHFEtqGoHbsudABB0kp295b9M3WV5YRgYY9IX7zwtX5J2dnrCoUp3X4/FGqkPJRw5VliBDlzYGslYJ0nXiI+7o0Z4fuG2v+pFl3BrCcyq8qJO/U0/6fmflSzMnhKtg2LZZGs5MDU9pc87ehFshiGik0Oo6y5byYBJaI8Ngm+J5IFDMKktJ7LdHeGfZ3WZAl8xjtdB/Sbn669impfYWinwsyxs5HsfcGTLV8PwffUeZMwjtCn0hux5TBapJ0f6Wab0Q8REQqAEP15xM/Y6tZMeyhubHzeaTN/6+K11w6Snkh1gI87dk9R/m45G1eQJvelmESJ5FfdjYLxowQPkrV3KHrM/Zsw9Co3eBLSiITlTzgcatMZNhjyonDbDP8TTWm0j7ZPe95HQ9f3klvmpVS8gGgNHNpRV9cFfcnOQtfbFwwz9WH366isBj07dCLXJ8kBKs2E6Z+8OKy3rzi6zW3uZPXCKL7VSAdQn3KaWmrFmjVqUuc9cm3ewp6/vnTi3twZWkY0OtKvqOh9/2shyMX8cRlm6kTAZARV9HrdwciFwBQgk8lOX/j3bvQSlTb8CwTC8rM2GsSR0Ml38T/brha+wIGIRJdW6O/zFBmA3rms6TBr5yes+EQ4lV
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199018)(186003)(7696005)(71200400001)(478600001)(107886003)(64756008)(316002)(76116006)(66476007)(6916009)(66556008)(66446008)(66946007)(6506007)(9686003)(26005)(54906003)(8676002)(4326008)(41300700001)(52536014)(5660300002)(122000001)(2906002)(38100700002)(86362001)(558084003)(55016003)(38070700005)(33656002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0QIEhx0NShEP7OS9gQKCQrQFAN/Fh3aYnrXy70LkFtIkzEKlX8bqqiBDVSDP?=
 =?us-ascii?Q?OnwyxD3VjAUxpl2GO2rCmJVfs64hB5KzRC9iL2Y5HZdxKAzuaFHYwfTluL8f?=
 =?us-ascii?Q?5jrhW8DAxmP9u2Ir4BfH7R9x/Dejt3vjPLUP8A3wGgMW3WNpNyhjYol2e1Sm?=
 =?us-ascii?Q?ayg9aXPJfoVQ+9zIPhd0MHsp+VoUNoDSAV4+I55xhG18IzzWXl7ItpArsxnH?=
 =?us-ascii?Q?jaFh6bjrSkFPlogPLDTMAKOczMTJjoW0XlWk+Aw3reaE3UWQCKJHuyM5qEBf?=
 =?us-ascii?Q?slLCXwR2o8AFJDExbclFKfyyNtioyBjDy33tJOc8rz33cLUH7Zhk/gHNyUrs?=
 =?us-ascii?Q?sbxA8Tyj8daZnyWwkYRI0kCHEGrsZ22nC21nsd7+ALiJ7+4DODPZWnKju8cU?=
 =?us-ascii?Q?ci7rfKMHPTnbpomSVxkK6HwBfGQ2FG22yzBPFEfO/ukdMWTYjsLgp9fg/Stb?=
 =?us-ascii?Q?gFQDOzjR5cc4ONJfNNrVIGY19i1l+T+Zb9pHVsbrcvbj83GH4X+rsib+jkPB?=
 =?us-ascii?Q?18+p4R8vQ437cj1LjzeuZbuR4h6129eu4vyKWk1v9z6OOLyNX6QUSCj4wA+Z?=
 =?us-ascii?Q?21OBlWdeUJE8Hz8LIbw82XNvGLknAQAVHYpxiZApqhzgwYIC8/zEi2D1aift?=
 =?us-ascii?Q?aOtDF0oY/f2EgwGWaASblBIXXgyT4xyOTUb2zHOAkoUdM7ZtqS3QobpYrUfv?=
 =?us-ascii?Q?vlXrZZr52EynpFdhzV0m21h06NJ1oJzpjiotTaxGxZ1EuCLSRhONB+eF/OSw?=
 =?us-ascii?Q?TNrSrJrmbXgLffE1q80FRyxFzxO9EX2anncAUVjoxEMNMYaQ3/GrOQeUYUvK?=
 =?us-ascii?Q?FeHXx/eyFkC4m90gStfTjwqAkEgGRhD80jxTcV8mQE+7U0VQjlgfmewqPqyD?=
 =?us-ascii?Q?EUa9BbY2zAwhoeZJJFt17Be2OcjtUoC4voTeo7WQQ1RNh8ZQNXoVtXiOejct?=
 =?us-ascii?Q?4LC0+4GTO65BYQarzk5LACrkIPZIwKgY0ZpIPnwmXW1b3MEYFfRWXq+oZxJZ?=
 =?us-ascii?Q?a8ss2L/FdPXqSOqN2AboaVuLeHVzxiN84wXFRRbfGPNKP8BlV8xgO4aTme8d?=
 =?us-ascii?Q?Go/I19vm1LyTilCMlAf79MmS6T0AxIojpQhrq6RYHJCSon5XCxjWFs7EstgQ?=
 =?us-ascii?Q?Y33gTA5Z/RzHT1i1u+ef6/8+6ZB4zxhs5Qzi6mkSDyoxqw3OULVVD5t+9kLN?=
 =?us-ascii?Q?YzQf/mH2AksR0vsrtm3bR7TYpqQcvTRaLJHBM2VUnntVt8hi7BBA/1rx7R1S?=
 =?us-ascii?Q?BuxCMPx1EPUzRTCaFtLMlESaRvApwgUl2gqXoGNdYyUNSAmu/EVJ4Bssj5VA?=
 =?us-ascii?Q?1knsLkWEp3Zl0myBDgtfkoUA1PzO0WC/XRDDQFhO1QDMNBddposrQ01badvi?=
 =?us-ascii?Q?M1qNbruj2GO7at8cT0lAbZ5JByJF7s6kljpKt3ItXFHSjUwhFom5gjkinLjA?=
 =?us-ascii?Q?cScL/9WKq340fFkFobjgNSXwiVPsPPxBpJjpznMUnx49JH4ZY/X1Xa+wKQC5?=
 =?us-ascii?Q?LXcyFQp7AlZiOjOV7ts0k5oKEfxkqdlZ2CsNX9dtWMX8cRwBwHBT4dnazyE3?=
 =?us-ascii?Q?5yA+6fNJYVE2FXrNUgc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d11f840-aa3e-434e-93b1-08db2af6a1ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 16:58:17.0947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 44Rj7OLMmZ0oKTCCZMhGLVjQJYdE+8hmf68BePWWRjfVXfxCnrUnTw1mr5btYjsvjEL2z4q2zLJDk+Xm7aKEHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8016
Subject: [virtio-dev] RE: [PATCH v3 6/8] transport-ccw: Refer to the vq by its number


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, March 22, 2023 12:56 PM
>=20
> Refer how?  \field{} is not a cross reference. It's a way to make field n=
ames
> stand out to make sure readers do not think this is plain english.
>=20
Ok. will change.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

