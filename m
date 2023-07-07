Return-Path: <virtio-dev-return-13299-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747FBEB64D9
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 03:54:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C9B7379133
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 03:54:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AB492986818
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 03:54:53 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9AA129867B6; Fri,  7 Jul 2023 03:54:53 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 73ADC986828;
	Fri,  7 Jul 2023 03:54:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b56Ko1EugPeNjXd8Z8PLVoRBR3ETtmS0qk7LJ7zZei+O8sd4gKlsAhgU32NG2H8W/B9OXCLmc1r7x9xJxId0HbZUSuKRi3yeTYncazbYSVTEimvXfJr6Q/nnLwLmY/zX0SNhJx9xrXiNofzaLGgDqFLPgwiucZqlgYjDozlcsEceEYOqJOB2EguXQWf1IkHo/A8xHpduUWY6SITJF2BsegPltpgeX9L+H9ejrfU2Nd/ZaWhLMJFqzDyXeePn/XbmMI8dDvYAPXodjUATLOIxh6yGL040Jl8/yWZ8qWXtwYXXN73JMDHFl4ns998KoeT35kh545DSKUsJwVUBpAL8rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjeBZlv1yDrnxBx7Jw6RTb1Qz6WkARcC47Il+TYXjTU=;
 b=IeA/L++RWYPdCY7PZUURKqZrtSVhavebOm4Muw9Rz792zkck2AVz7l4aGWAL9ZHCp5dPxGU5364Tq/2CKXpIaoRVfeA2L1h883dK9ge+kpnhmJ9m272o5Jw4wqdVFqtLFy7ClKs2bEVmki/6mVvchUWTp8CNRcsohHLI7fn4nvLOiCbsqiuuTFevJk34yabpa4elS24AbnAAHQIQv2schykdxeEOBfk6+wl3IJUUCcAftcUjoai/UHozW54GkA1PjbmHph0B0fwaI8Ivcbfwl50yilAcWJZxsG4dyTbUc0H4VhEu/RrZkaa/b9vSbx3+3dieODmx1cfiXTsJUSdKMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Shahaf Shuler
	<shahafs@nvidia.com>
Thread-Topic: [PATCH v11 3/3] admin: Add group member legacy register access
 commands
Thread-Index: AQHZsFC4cpNjg8LQ3UGurskCWJrr6K+tU9yAgABT0ZA=
Date: Fri, 7 Jul 2023 03:54:31 +0000
Message-ID:
 <PH0PR12MB5481DF6CC374634FE1A1AAF9DC2DA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230706212722.97973-1-parav@nvidia.com>
 <20230706212722.97973-4-parav@nvidia.com>
 <20230706174904-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230706174904-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MN0PR12MB6271:EE_
x-ms-office365-filtering-correlation-id: 63029237-f87b-4241-12c2-08db7e9dde92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 iWryOGViINi8gpMkf9XD7bGHaBx10L2+cvuVLloVP8KtAzvHCLC/0bW5E6yX916SsM0uR0iGoKi9/fsCf0cl1/OmDu8fAJ+keaoqsikEPeYWESeuPpjx3YgPSjXTGEkM/aG3IhpHLd1NQMpltQOdzZvnU8GJ8I0t2iTNKiTNLgjE7fzBC/3+iWMzEAtn9s08whNaHXQT2Wd70PJieEEoX2VZ5BMSSJhqKfHh7sroaDCKA1rAMz8dDNbHQugi/4XIeTgSIxf3wtm+ZOzazeZodb40USB7mG6r+pA9bsXB240TA1v5zM9eFRq5wWbzNaJPTmFAma7VFqSbOSizbdPDrwqah2m2l6xHsyjnocUeXBC/954NadJU5R3X7BoDnnpgbE49G8oisxyxn5HRekj2GqWnzTtb1WQGZCqGdbEUvleXIojUSuKtjoSxBag7m//Mt7LNFywe9CvcwcIp0PyVCNUfv3rCFHZmAf29SrCZXrG2fY1pgwHVIyE2NgwNq/df6UAZmFPLk1rGR1YLUPzZjO4+JAKdX/t1jOty8p44Plo0IObv6KiFX7BvuvjDPkJ5XehEgNYAcHE+oSawXVaYtfGK15vFi8RrcdhG5b2nK2h/0FsMVmf8n3jqrfYkt9Vt
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(451199021)(6506007)(54906003)(41300700001)(7696005)(38100700002)(83380400001)(71200400001)(122000001)(107886003)(186003)(9686003)(86362001)(55016003)(38070700005)(64756008)(478600001)(66446008)(66946007)(4326008)(8936002)(66556008)(76116006)(33656002)(6916009)(8676002)(2906002)(66476007)(26005)(52536014)(316002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VHdFMnNQcnlsR1c5blNXRjNySHFQdkxhcWhRY0RqeXJ0QzhGTDlYQmJNT1la?=
 =?utf-8?B?cFVPdVJNSWxBS1ErRHdreWJTdEc5aG90NVNiMjB4WXdpeEJmSlF3TEdhSDhF?=
 =?utf-8?B?SWpPdkczUEt3cXRLRHBxcGhNbXJqc1RjbitkOTdoUFYrREdzUThUZXA3dmM2?=
 =?utf-8?B?K3JXeHR6VGp2WVlrQ3BtNE9GVERqN1ZyclFiVDdINWNYdXRTTWd1OElGbWdD?=
 =?utf-8?B?bDdpenJBdDFwc2Q0TGNRdnU5N2Vqc01JWUxGVzJvNmpOaWJ3S05KMllOTmwy?=
 =?utf-8?B?bWNNY0FjTThpQkFyQnhmQ0pxd3IyRkdtMkJtSDgyczY4em9QZzJTYzNGRHpV?=
 =?utf-8?B?M0JTNWZCd3RobFBueXB5T0haSFMxYzBmaWx2WXd4NUxHaWR5cGNkbE5GaEhx?=
 =?utf-8?B?Vkc3Sk90ekR6a3c2WUJjTkJBUXA2a2J6dGhrT0JqQ0IvUkNnbDRqdGdKQ0Q2?=
 =?utf-8?B?RnprbmdhZ3NoY3NOZjNMZTFaZndZYnZCU2ZaVlgvY0pDVmFlUlB2cGxVQVRI?=
 =?utf-8?B?bml3SUJUK3lxcFppRnB2YUM3TzZDZFBRL0U4aU54YkE3OEhUOWN2M00yVUNw?=
 =?utf-8?B?S3hUTWNxQ2Z6SGRxalViQnB2NzNYcmJjZ25vQWh6bFZVeFdVWnVUQ2NYUFR1?=
 =?utf-8?B?bGdOT0JwRVdycXNzaXo3R3c2UE9vZTdZZGZwOHVSSm9zclB1TXlhR2pBSjNo?=
 =?utf-8?B?Tjk3Q3lRUGdVSFp0cHdhaWkzRE5hbHpITmV5V09HN3JYL3kyc1lUNmJ6SWY1?=
 =?utf-8?B?Rng5T1lyL0RvbkQ4NzVIaFczb3J2Wjh2V0F2aWlGNzAzNFk5WjR1bENjeGhz?=
 =?utf-8?B?K3pEOWJta1NMT2NXbDdaTGR2S0lPaWRVU3VqWS9nRWUxamF6a01yUWsrR3RO?=
 =?utf-8?B?eGljbmMxdVZPYklmY0pDQlF0cUZySTVZNFBOUWw2b1ZFS2xjZW93anF5K3JM?=
 =?utf-8?B?aVRuakdXN2V0dVVJcVZlRzk3ODFBODlTS3NZN0NnUGJ2WFRydlA0UUhkMXdW?=
 =?utf-8?B?R0dIekl5VE1VRXZOTkhZQzZZOFRKQnhUclp1Q2F1UVB2dVhkSFZNTU1ZUS9C?=
 =?utf-8?B?Tk9zd1ppdFJWRXh1d3Q5Q2FoWjdmU1Vqc1p2YzNDakZPSDNlTzhiNWlxQzFI?=
 =?utf-8?B?NS8xdFVZaUU1MFBkK0plVVlNcnJKZDczOVc3d2Z4bDd1ZWJmOXBEMm00RnRQ?=
 =?utf-8?B?ODBpUnFUcWxRNlcxMFhJUlZvZWkzL1g3c2NkcEcvbVlYbWt1cTJaZlZqRHl4?=
 =?utf-8?B?aUdHK1J0QzFsMUgwZFRycVFuczdMdEMvTkRXK09KOFM4TUtRNStWUUtDYlo1?=
 =?utf-8?B?STZUd2VodWhLR041MExoN2JCQkp3Tk5WWnQ5WlB2ZGZMK1NLYVZNbk11NFJQ?=
 =?utf-8?B?bmcrUlJyUHd5MHcxSGN1alhGcEFiQk5oVGtZSmJ5K2tRV01QZFBGRnpUNlhh?=
 =?utf-8?B?V29YS2ViZkZNWU96TlpEZHRra0xGWnUwbVA3WW9PY0tTUlhPeUoyOVZjbERr?=
 =?utf-8?B?Q1d1SFN2QkFDZlNiRFJRWmNJN3dZalhCZ045TDVsSG9rOTJVcm9odk1pTkV0?=
 =?utf-8?B?MDVvL3lXNVI3N1FvUmEwVmJTdUV1ZHl5YTdzS2JxYVFWenQva1pzUzZjS0xT?=
 =?utf-8?B?d1VJRU50RjZ3RGN1eXM2TEwvK1NjZ1VMQklhLzVtcWdWRnZEZkVrRWNJSFI4?=
 =?utf-8?B?M1A0YzRKd2FndXY4ZXNJKzlzQjBSUHlBaWUyR0xOVnYyeXlQbjFkWlZzUW5N?=
 =?utf-8?B?dG9VMHVuV3g2SDhJekdzRVVaT1ZJVHBjVDlWMlJrNU1HK2hWTG1oVG81Qnk1?=
 =?utf-8?B?dkNVcXl6OXJMZ0tjR0lEb1ZDN0M1M3dXM21Kcys4cXpNaVZiR2Q3bVdOU0JL?=
 =?utf-8?B?Nk9sMDkvVGJNZkZCSmw3a3U5TnVFa2JCdGVvRWhNajhsK1AyNCtMZ1lCTy9i?=
 =?utf-8?B?cVRxaG5FWjdSL1ZFcG1wL1R3ZGFEZjhrUFBuemRFaVUwcStMU1RjZHIzdU9x?=
 =?utf-8?B?TkJrSnVFZG9VMHVubEt6Y0tydmZxYmNkem1NZnhabUZKQzF2dTA5eHJrZUI5?=
 =?utf-8?B?V0tDL3lhZFBGZFFFMHNmbFphUWsweFE2ZitYZXk1MGJsWHhidDUwSEp4Vkk2?=
 =?utf-8?Q?6KJc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63029237-f87b-4241-12c2-08db7e9dde92
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 03:54:31.1823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DWb5MdxDrbDnrLN5CifubtEy7m7REL08SJidyo8RWW+c/MephCbIZfSQrijTkmcUU1y7E/PG3elyu1gTq/NLrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6271
Subject: [virtio-dev] RE: [PATCH v11 3/3] admin: Add group member legacy register access
 commands

DQo+IEZyb206IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+DQo+IFNlbnQ6IFRo
dXJzZGF5LCBKdWx5IDYsIDIwMjMgNjozNiBQTQ0KDQpbLi5dDQoNCj4gSSBub3RpY2UgeW91IGRl
Y2lkZWQgdG8gc2lsZW50bHkgaWdub3JlIG15IHN1Z2dlc3Rpb24gdG8gZG9jdW1lbnQgaG93IGFy
ZQ0KPiBub3RpZmljYXRpb25zIHBlcmZvcm1lZC4gUmVwZWF0aW5nIG15c2VsZiBsaWtlIHRoaXMg
aXMgZGVzcGlyaXRpbmcgZm9yIG1lLg0KSSBhbSBzb3JyeSBpZiBpdCBhcHBlYXJlZCB0aGF0IHdh
eSwNCkJ1dCBubywgSSBkaWRu4oCZdCBzaWxlbnRseSBpZ25vcmVkLg0KDQpJIGFkZGVkIHRoZSBk
ZXNjcmlwdGlvbiBhcyBiZXN0IEkgY291bGQgZmluZCBpdCwgYnV0IHlvdSBjb21tZW50ZWQgYWJv
dXQgaXQgYmVpbmcgbWVzc3kgd2l0aCBtaXhpbmcgdXAgdGhlIHRlcm1pbm9sb2d5Lg0KSSByZXdy
b3RlIGl0IGluIHYxMiwgaXQgbG9va3MgYmV0dGVyIG5vdy4gUGxlYXNlIGNoZWNrLg0KDQo+IFBs
cyByZS1hZGQgZXNwZWNpYWxseSBzaW5jZSB5b3UgYWxyZWFkeSBkb2N1bWVudCBpdCBmb3IgdGhl
IGNmZ19Xcml0ZSBhY2Nlc3MNCj4gbWV0aG9kIGFueXdheS4NCj4gDQpBZGRlZCB3aXRob3V0IGNp
dGF0aW9uIHRvIGh5cGVydmlzb3IgZXRjLg0KDQo+IA0KPiBhbHNvIGluIGEgY29uZm9ybWFuY2Ug
c2VjdGlvbiwgZG9jdW1lbnQgdGhlIGVmZmVjdCBvZiBub3RpZmljYXRpb24gYmVpbmcgdGhlDQo+
IHNhbWUgYXMgbm90aWZpY2F0aW9uIHRocm91Z2ggbGVnYWN5IGludGVyZmFjZS4NCg0KUENJIHNw
ZWNpZmljIHRoaW5ncyB3ZXJlIGNvcGllZCBmcm9tIHRoZSBjdXJyZW50IHNwZWMgcmVmZXJlbmNl
IGluIHRoZSBub3RpZmljYXRpb24gY2FwYWJpbGl0eSBzZWN0aW9uLg0KQWxsIHRoZSBjaGFuZ2Vz
IHlvdSBzdWdnZXN0ZWQgYXJlIGRvbmUuDQpDYXB0dXJlZCBpbiB0aGUgY2hhbmdlIGxvZyBvZiB2
MTIuDQoNClRoYW5rcyBhIGxvdC4NClNpbmNlIG1hbnkgcGFydHMgYXJlIHJld3JpdHRlbiBhcyB5
b3Ugc3VnZ2VzdGVkIGluIHRoZSB0aHJlYWQsIA0KSSBwcmVmZXIgdG8gYWRkIHlvdXIgU2lnbmVk
LW9mZiB0byBpbiB2MTMgaWYgd2UgbmVlZCByb2xsIGl0IG9yIHdoZW4gaXQgaXMgbWVyZ2VkLCBw
bGVhc2UgYXBwbHkgaWYgeW91IGZpbmQgaXQgYXBwcm9wcmlhdGUuDQpJdCBpcyBhdCBsZWFzdCBp
bXBvcnRhbnQgdG8gbWUgdG8gYWRkIGl0IHlvdXJzIFNpZ24tb2ZmLg0K

